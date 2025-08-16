import os
import argparse
import psutil
from time import sleep
import termplotlib as tpl
import subprocess

# Argument parser setup
parser = argparse.ArgumentParser()

# Command-line argument for the command to monitor
parser.add_argument("command", help="The command to launch and monitor")

args = parser.parse_args()

def monitor_process(pid):
    try:
        process = psutil.Process(pid)

        # Data to plot CPU and Memory usage
        cpu_data = []
        mem_data = []
        time_data = []

        while process.is_running():
            os.system("clear")
            # Get CPU and Memory usage
            cpu = process.cpu_percent(interval=1)
            mem = process.memory_info().rss / (1024 * 1024)  # Memory in MB
            time_data.append(len(time_data) + 1)  # x-axis data (time in intervals)

            # Add data to lists
            cpu_data.append(cpu)
            mem_data.append(mem)

            # Plot using termplotlib
            fig = tpl.figure()

            # Plot CPU and Memory usage as separate lines
            fig.plot(time_data, cpu_data, label="CPU Usage (%)")
            fig.plot(time_data, mem_data, label="Memory Usage (MB)" )

            # Add labels and title
            # fig.set_labels("Time (seconds)", "Usage")
            # fig.title(f"Resource Usage for PID: {pid}")

            # Show the plot in the terminal
            fig.show()

            # Clear the terminal screen before next update
            sleep(1)
        else:
            print("Process finished")

    except psutil.NoSuchProcess:
        print(f"Process with PID {pid} does not exist.")
    except psutil.AccessDenied:
        print(f"Permission denied to monitor process with PID {pid}.")
    except Exception as e:
        print(f"Error: {e}")

def launch_process(command):
    """ Launch the process and return its PID. """
    process = psutil.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return process.pid

if __name__ == "__main__":
    # Launch the command
    pid = launch_process(args.command.split())

    # Monitor the process
    monitor_process(pid)
