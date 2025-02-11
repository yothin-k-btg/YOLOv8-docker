# Dockerfile extension of Ultralytics' Docker image by JavierMtz5

FROM ultralytics/ultralytics:latest

ENV APP_HOME=/home/app
WORKDIR ${APP_HOME}

# Copy the requirements file and install dependencies
COPY ./requirements.txt ${APP_HOME}/requirements.txt
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --no-cache-dir --upgrade -r ${APP_HOME}/requirements.txt
# RUN pip install --no-cache-dir --upgrade -r ${APP_HOME}/requirements.txt


# Copy the app directory
COPY ./app ${APP_HOME}/app
COPY ./yolov8n_test.pt ${APP_HOME}/yolov8n_test.pt

EXPOSE 8080

# fastapi run app/main.py --port 8080
CMD ["fastapi", "run", "app/main.py", "--port", "8080"]

# uvicorn app.main:app --reload
# CMD ["uvicorn", "app.main:app", "--reload"]