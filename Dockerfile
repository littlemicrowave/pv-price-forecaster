FROM python:3.10.16
WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8080
LABEL com.centurylinklabs.watchtower.enable="true"
CMD ["python3", "app/app.py"]
