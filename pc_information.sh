#!/bin/bash

# Information about processor
echo "Model name: $(lscpu | grep -i 'model name'|tr -s ' '|cut -d ' ' -f3-)"
echo "Architecture: $(lscpu | grep 'Architecture' | awk '{print $2}')"
echo "CPU op-mode(s): $(lscpu | grep 'CPU op-mode(s)' | awk '{print $3}')"
echo "CPU(s): $(nproc --all)"
echo "Vendor ID: $(lscpu | grep 'Vendor ID' | awk '{print $3}')"
echo "Virtualization: $(lscpu | grep 'Virtualization' | awk '{print $2}')"

# Information about OS
echo ""
echo "OS Information:"
echo "Kernel name: $(uname -s)"
echo "Kernel release: $(uname -r)"
echo "Kernel version: $(uname -v)"
echo "Operating system: $(uname -o)"

