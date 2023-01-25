#!/bin/bash
pip install triton==2.0.0.dev20221120
pip install Pillow==9.1.0
sed -i 's/demo.launch(debug=True, width="80%", height=2000)/demo.launch(debug=True, share=True, port=7862)/' /app/app.py
python /app/app.py
