{ pkgs, ... }:

let
  pearrun = pkgs.writeShellScriptBin "pearrun" ''
    export PATH=${ pkgs.lib.makeBinPath [ pkgs.curl pkgs.jq pkgs.noctalia ] }:$PATH

    set -euo pipefail
    
    PORT="''${PEARRUN_PORT:-26538}"
    BASE="http://localhost:''${PORT}"
    
    ICON_PLAY=$'\uf04b'       # nf-fa-play
    ICON_PAUSE=$'\uf04c'      # nf-fa-pause
    ICON_NEXT=$'\uf051'       # nf-fa-step_forward
    ICON_PREV=$'\uf048'       # nf-fa-step_backward
    ICON_LIKE=$'\uf004'       # nf-fa-heart
    ICON_DISLIKE=$'\uf165'    # nf-fa-thumbs_down
    ICON_SHUFFLE=$'\uf074'    # nf-fa-random
    ICON_REPEAT=$'\uf01e'     # nf-fa-repeat
    ICON_SEARCH=$'\U1F50D'    # 🔍 emoji
    ICON_QUEUE=$'\uf03a'      # nf-fa-list
    ICON_OPEN=$'\uf08e'       # nf-fa-external_link
    ICON_STATUS=$'\uf05a'     # nf-fa-info_circle
    ICON_REMOVE=$'\uf014'     # nf-fa-trash
    ICON_CLEAR=$'\uf12d'      # nf-fa-eraser
    ICON_BACK=$'\uf060'       # nf-fa-arrow_left
    ICON_MUSIC=$'\U1F3B5'     # 🎵 emoji
    
    API_CODE=0
    
    api() {
        local method="$1" path="$2" data="''${3:-}"
        local response body
        response=$(curl --connect-timeout 3 --max-time 10 -sS         -X "$method"         -H 'Accept: application/json'         ''${data:+-H 'Content-Type: application/json' -d "$data"}         -w $'\n%{http_code}'         "$BASE$path") || exit 1
        API_CODE="''${response##*$'\n'}"
        body="''${response%$'\n'*}"
        if [ -n "$body" ]; then
            printf '%s\n' "$body"
        fi
    }
    
    require_server() {
        if ! curl --connect-timeout 2 -sf -o /dev/null "$BASE/api/v1/song"; then
            echo "pearrun: API server not reachable at $BASE" >&2
            exit 1
        fi
    }
    
    require_noctalia() {
        if ! command -v noctalia >/dev/null 2>&1; then
            echo "pearrun: noctalia not found in PATH (start Noctalia first)" >&2
            exit 1
        fi
    }
    
    SONG_TITLE=''' SONG_ARTIST=''' SONG_URL='''
    SHUFFLE=''' REPEAT=''' LIKE=''' SONG_ISPAUSED='''
    
    load_state() {
        local song
        if song=$(api GET /api/v1/song 2>/dev/null) && [ -n "$song" ]; then
            SONG_TITLE=$(jq -r '.title // empty' <<<"$song")
            SONG_ARTIST=$(jq -r '.artist // empty' <<<"$song")
            SONG_URL=$(jq -r '.url // empty' <<<"$song")
            SONG_ISPAUSED=$(jq -r '.isPaused // false' <<<"$song")
        fi
    
        SHUFFLE=$(api GET /api/v1/shuffle 2>/dev/null | jq -r '.state // false')
        REPEAT=$(api GET /api/v1/repeat-mode 2>/dev/null | jq -r '.mode // empty')
        LIKE=$(api GET /api/v1/like-state 2>/dev/null | jq -r '.state // empty')
        if [ -z "$SHUFFLE" ]; then
            SHUFFLE=false
        fi
        return 0
    }
    
    status_line() {
        printf '%s | repeat %s | shuffle %s'         "''${SONG_TITLE:-nothing playing}"         "''${REPEAT:-?}"         "$SHUFFLE"
    }
    
    menu() {
        local response
        response=$(printf '%s' "$1" | noctalia dmenu -p 'pearrun: ') || return 1
        printf '%s' "$response"
    }
    
    dispatch() {
        case "$1" in
            "$ICON_PLAY Toggle play/pause") api POST /api/v1/toggle-play >/dev/null ;;
            "$ICON_PLAY Play")        api POST /api/v1/play >/dev/null ;;
            "$ICON_PAUSE Pause")      api POST /api/v1/pause >/dev/null ;;
            "$ICON_NEXT Next")        api POST /api/v1/next >/dev/null ;;
            "$ICON_PREV Previous")    api POST /api/v1/previous >/dev/null ;;
            "$ICON_LIKE Like")                api POST /api/v1/like >/dev/null ;;
            "$ICON_DISLIKE Dislike")          api POST /api/v1/dislike >/dev/null ;;
            "$ICON_SHUFFLE Toggle shuffle"|"$ICON_SHUFFLE Shuffle on")             api POST /api/v1/shuffle >/dev/null ;;
            "$ICON_REPEAT Next repeat mode"*) api POST /api/v1/switch-repeat '{"iteration":1}' >/dev/null ;;
            "$ICON_SEARCH Search…")          search_menu ;;
            "$ICON_OPEN Open in browser")     open_current ;;
            "$ICON_QUEUE Queue…")             queue_menu ;;
            "$ICON_STATUS Status")            status_line ;;
        esac
    }
    
    open_current() {
        if [ -n "$SONG_URL" ]; then
            command -v xdg-open >/dev/null 2>&1 && xdg-open "$SONG_URL" &
        fi
    }
    
    play_video() {
        local vid="$1" q idx i
        api POST /api/v1/queue "{\"videoId\":\"$vid\",\"insertPosition\":\"INSERT_AFTER_CURRENT_VIDEO\"}" >/dev/null
        for ((i = 0; i < 20; i++)); do
            q=$(api GET /api/v1/queue 2>/dev/null)
            idx=$(jq -r --arg v "$vid" '
                .items | to_entries[] |
                select((( .value.playlistPanelVideoRenderer.videoId // "")
                     // (.value.playlistPanelVideoWrapperRenderer.primaryRenderer.playlistPanelVideoRenderer.videoId // "")) == $v) |
                .key' <<<"$q" | tail -n 1)
            [ -n "$idx" ] && break
            sleep 0.5
        done
        if [ -z "$idx" ]; then
            echo "pearrun: could not locate '$vid' in the queue after insert" >&2
            return 1
        fi
        api PATCH /api/v1/queue "{\"index\":$idx}" >/dev/null
    }
    
    queue_jump() {
        api PATCH /api/v1/queue "{\"index\":$1}" >/dev/null
    }
    
    queue_remove() {
        api DELETE "/api/v1/queue/$1" >/dev/null
    }
    
    queue_handle() {
        local sel="$1" idx
        if [[ "$sel" == *"Clear queue"* ]]; then
            api DELETE /api/v1/queue >/dev/null
        elif [[ "$sel" == *"Back"* ]]; then
            queue_menu
        elif [[ "$sel" == *"Remove song"* ]]; then
            queue_remove_menu
        elif [[ "$sel" =~ (#[0-9]+) ]]; then
            idx=$((10#''${BASH_REMATCH[1]#\#}))
            if [[ "$sel" == *"Remove"* ]]; then
                queue_remove "$idx"
            else
                queue_jump "$idx"
            fi
        fi
    }
    
    queue_titles() {
        api GET /api/v1/queue 2>/dev/null |
            jq -r '.items[]? |
              (.playlistPanelVideoRenderer // .playlistPanelVideoWrapperRenderer.primaryRenderer.playlistPanelVideoRenderer) |
              [(.title.runs[]?.text)] | join("")'
    }
    
    queue_artists() {
        api GET /api/v1/queue 2>/dev/null |
            jq -r '.items[]? |
              (.playlistPanelVideoRenderer // .playlistPanelVideoWrapperRenderer.primaryRenderer.playlistPanelVideoRenderer) |
              [ (.longBylineText.runs[]? | select(.navigationEndpoint != null) | .text) ][0] // ""'
    }
    
    queue_menu() {
        load_state
        local titles artists count i sel
        readarray -t titles < <(queue_titles)
        readarray -t artists < <(queue_artists)
        count=''${#titles[@]}
        [ "$count" -eq 0 ] && { echo "pearrun: queue is empty" >&2; return 1; }
    
        local entries=("$ICON_QUEUE Queue ($count songs)")
        for ((i = 0; i < count; i++)); do
            entries+=("$ICON_PLAY #$i ''${titles[$i]} — ''${artists[$i]}")
        done
        entries+=("$ICON_REMOVE Remove song" "$ICON_CLEAR Clear queue")
    
        sel=$(menu "$(printf '%s\n' "''${entries[@]}")") || return 0
        queue_handle "$sel"
    }
    
    queue_remove_menu() {
        local titles artists count i sel
        readarray -t titles < <(queue_titles)
        readarray -t artists < <(queue_artists)
        count=''${#titles[@]}
        [ "$count" -eq 0 ] && { echo "pearrun: queue is empty" >&2; return 1; }
    
        local entries=("$ICON_REMOVE Remove from queue ($count songs)")
        for ((i = 0; i < count; i++)); do
            entries+=("$ICON_REMOVE Remove #$i ''${titles[$i]} — ''${artists[$i]}")
        done
        entries+=("$ICON_CLEAR Clear queue" "$ICON_BACK Back")
    
        sel=$(menu "$(printf '%s\n' "''${entries[@]}")") || return 0
        queue_handle "$sel"
    }
    
    SEARCH_BASE='.contents.tabbedSearchResultsRenderer.tabs[0].tabRenderer.content.sectionListRenderer.contents[] | select(.itemSectionRenderer?) | .itemSectionRenderer.contents[] | select(.musicResponsiveListItemRenderer?) | .musicResponsiveListItemRenderer | select(.playlistItemData.videoId != null)'
    
    search_video_ids() {
        jq -r "$SEARCH_BASE | .playlistItemData.videoId"
    }
    
    search_titles() {
        jq -r "$SEARCH_BASE | [(.flexColumns[0].musicResponsiveListItemFlexColumnRenderer.text.runs[]).text] | join(\"\")"
    }
    
    search_artists() {
        jq -r "$SEARCH_BASE | [ (.flexColumns[1].musicResponsiveListItemFlexColumnRenderer.text.runs[]? | select(.navigationEndpoint != null) | .text) ][0] // \"\""
    }
    
    search_menu() {
        local query payload resp ids titles artists count i sel
        require_noctalia
        query=$(noctalia dmenu -p 'Search YT Music: ' </dev/null) || return 1
        case "$query" in
            *[![:space:]]*) ;;
            *) return 1 ;;
        esac
    
        payload=$(jq -nc --arg q "$query" '{query:$q}')
        resp=$(api POST /api/v1/search "$payload")
    
        readarray -t ids < <(search_video_ids <<<"$resp")
        readarray -t titles < <(search_titles <<<"$resp")
        readarray -t artists < <(search_artists <<<"$resp")
        count=''${#ids[@]}
        [ "$count" -eq 0 ] && { echo "pearrun: no results for '$query'" >&2; return 1; }
    
        local entries=("$ICON_SEARCH Results · $query ($count)")
        for ((i = 0; i < count; i++)); do
            if [ -n "''${artists[$i]}" ]; then
                entries+=("$ICON_PLAY #$i ''${titles[$i]} — ''${artists[$i]}")
            else
                entries+=("$ICON_PLAY #$i ''${titles[$i]}")
            fi
        done
    
        sel=$(menu "$(printf '%s\n' "''${entries[@]}")") || return 0
        if [[ "$sel" =~ (#[0-9]+) ]]; then
            idx=$((10#''${BASH_REMATCH[1]#\#}))
            play_video "''${ids[$idx]}"
        fi
    }
    
    show_menu() {
        load_state
        require_noctalia
    
        local tab=$'\t'
        local header="$ICON_MUSIC Now playing$tab$(status_line)"
        local entries=("$header")
        if [ "$SONG_ISPAUSED" = "true" ]; then
            entries+=("$ICON_PLAY Play" "$ICON_NEXT Next" "$ICON_PREV Previous")
        else
            entries+=("$ICON_PLAY Toggle play/pause" "$ICON_PLAY Play" "$ICON_PAUSE Pause" "$ICON_NEXT Next" "$ICON_PREV Previous")
        fi
    
        local like_label="$ICON_LIKE Like"
        [ "$LIKE" = "LIKE" ] && like_label="$ICON_LIKE Liked"
        [ "$LIKE" = "DISLIKE" ] && like_label="$ICON_DISLIKE Disliked"
        entries+=("$like_label" "$ICON_DISLIKE Dislike")
    
        local shuf_label="$ICON_SHUFFLE Toggle shuffle"
        [ "$SHUFFLE" = "true" ] && shuf_label="$ICON_SHUFFLE Shuffle on"
        local rep_label="$ICON_REPEAT Next repeat mode"
        [ -n "$REPEAT" ] && rep_label="$ICON_REPEAT Next repeat mode (now $REPEAT)"
    
        entries+=("$shuf_label" "$rep_label")
        entries+=("$ICON_SEARCH Search…" "$ICON_QUEUE Queue…" "$ICON_OPEN Open in browser" "$ICON_STATUS Status")
    
        local sel
        sel=$(menu "$(printf '%s\n' "''${entries[@]}")") || return 0
        dispatch "$sel"
    }
    
    main() {
        require_server
    
        case "''${1:-}" in
            ''')        show_menu ;;
            play)      api POST /api/v1/play >/dev/null ;;
            pause)     api POST /api/v1/pause >/dev/null ;;
            toggle)    api POST /api/v1/toggle-play >/dev/null ;;
            next)      api POST /api/v1/next >/dev/null ;;
            prev|previous) api POST /api/v1/previous >/dev/null ;;
            like)      api POST /api/v1/like >/dev/null ;;
            dislike)   api POST /api/v1/dislike >/dev/null ;;
            shuffle)   api POST /api/v1/shuffle >/dev/null ;;
            repeat)    api POST /api/v1/switch-repeat '{"iteration":1}' >/dev/null ;;
            search)    search_menu ;;
            queue)     queue_menu ;;
            clear)     api DELETE /api/v1/queue >/dev/null ;;
            open)      load_state; open_current ;;
            status)    load_state; echo "$(status_line)" ;;
            song)      load_state; [ -n "$SONG_TITLE" ] && echo "$SONG_TITLE — $SONG_ARTIST" ;;
            *)
                echo "pearrun: unknown action: ''${1:-} (try: play pause toggle next prev like dislike shuffle repeat search queue clear open status song)" >&2
                exit 1
                ;;
        esac
    }
    
    main "$@"
  '';
in { home.packages = [ pearrun ]; }
