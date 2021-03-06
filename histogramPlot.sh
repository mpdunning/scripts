#!/bin/bash
#
# histogramPlot.sh: plots a histogram using areaDetector Stats plugin
# M. Dunning 4/27/13

args="[CAM PVPREFIX]"

function show_usage {
    echo "Usage: $0 $args"
}

if [ $# -ne 1 ]; then
    show_usage
    exit 1
fi

pvPrefix=$1
target=histogramPlot
arch=`uname -i`

if [ "$arch" = "i386" ]; then
    qArch=arch-32
else
    qArch=arch-64
fi

caput $pvPrefix:Stats1:EnableCallbacks 1
caput $pvPrefix:Stats1:ComputeHistogram 1

#/afs/slac/g/testfac/workspace/mdunning/qt/$target/$qArch/$target -m P=$1
edm -x -eolc -m P=${1}:,R=Stats1:,TITLE=Histogram,DATA=Histogram_RBV,XLABEL=Pixel,YLABEL=Counts,N=ArraySize0_RBV gcNDPlot.edl


exit 0

