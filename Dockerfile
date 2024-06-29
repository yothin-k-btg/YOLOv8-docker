# Dockerfile extension of Ultralytics' Docker image by JavierMtz5

FROM ultralytics/ultralytics:latest

ENV APP_HOME /home/app
WORKDIR ${APP_HOME}

ENV YOLOV8_MODEL_DIR ${APP_HOME}/app/model/model_weights/coco_detector.pt

# Copy the requirements file and install dependencies
COPY ./requirements.txt ${APP_HOME}/requirements.txt
RUN pip install --no-cache-dir --upgrade -r ${APP_HOME}/requirements.txt

# Copy the model and the training/test data
COPY ./app ${APP_HOME}/app

CMD ["fastapi", "run", "app/main.py", "--port", "8080"]