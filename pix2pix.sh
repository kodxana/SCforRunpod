#!/bin/bash
sed -i 's/demo.launch(debug=True, width="80%", height=2000)/demo.launch(debug=True, width="80%", height=2000, share=True)/' /app/app.py
python /app/app.py
