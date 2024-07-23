FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /usr/src/app

COPY src/lambda-functions/ ./lambda-functions/
COPY src/Rest-Interface.py ./Rest-Interface.py

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt



ENTRYPOINT ["python"]

CMD ["./Rest-Interface.py"]

