#!/bin/bash
pip install triton==2.0.0.dev20221120
pip install Pillow==9.1.0
sed -i 's/demo.launch(debug=True, width="80%", height=2000)/demo.launch(debug=True, width="80%", height=2000, server_name="0.0.0.0", server_port=7866)/' /app/app.py
sed -i 's/pipe = StableDiffusionInstructPix2PixPipeline.from_pretrained(model_id, torch_dtype=torch.float16, revision="fp16")/pipe = StableDiffusionInstructPix2PixPipeline.from_pretrained(model_id, torch_dtype=torch.float16, revision="fp16", safety_checker=None)/' /app/app.py
python /app/app.py
