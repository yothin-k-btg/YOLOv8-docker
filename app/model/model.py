from typing import Dict, List, Any
import json
from PIL import Image

import ultralytics
import ultralytics.engine
import ultralytics.engine.results
import albumentations as A
import numpy as np

__version__ = "0.1"

# model = ultralytics.YOLO('yolov8n.pt')
model = ultralytics.YOLO('yolov8n_test.pt')

# setup transformer
transformer = A.Compose([
    A.CLAHE(always_apply=True)
    
], bbox_params=A.BboxParams(format='yolo'))

def inference_on_path(imgs_path: str) -> List[Dict[str, Any]]:
    """
    Runs inference on the YOLOv8 architecture for the images available in the given path
    """
    results: ultralytics.engine.results.Results = model(source=imgs_path, show=False, conf=0.45)
    results_data = []
    for result in results:
        result_metadata = {
            'shape': result.orig_shape,
            'path': result.path,
            'detections': json.loads(result.tojson())
        }
        results_data.append(result_metadata)

    return results_data

def inference_on_img(img: Image) -> List[Dict[str, Any]]:
    """
    Runs inference on the YOLOv8 architecture for the given image
    """
    
    image_np = np.array(img)
    transformed = transformer(image=image_np)
    img = Image.fromarray(transformed['image'])

    results: ultralytics.engine.results.Results = model(source=img, show=False, conf=0.45)
    result_data = json.loads(results[0].tojson())

    return result_data
