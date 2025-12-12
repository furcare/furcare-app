#!/bin/bash
# Simple script to copy pre-built Flutter web files
echo "Copying pre-built Flutter web app..."
mkdir -p public
cp -r build/web/* public/
echo "Done!"
