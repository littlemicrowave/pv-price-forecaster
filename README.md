# Dockerized APP for the PV price forecasting project
Data analysis, preprocessing and modelling can be found here: [GitHub Link](https://github.com/littlemicrowave/pv-price-forecaster-AIDA)
# Configuration

You can simply pull image from dockerhub or build image using Dockerfile in the repo.

**docker-compose.yml** with watchtower service to continuously update the app image in case of update, which is a part of the deployment pipeline: 
```
services:
  watchtower:
    image: containrrr/watchtower
    environment:
      -  WATCHTOWER_POLL_INTERVAL=60
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    container_name: watchtower
    command: --label-enable
  app:
   image: wearecooked/pv-price-forecaster:latest
   ports:
    - 80:8080
```
# ☀PV Price Forecaster

**A simple Flask web application for predicting solar panel prices using XGBoost**, developed as part of the AIDA project course at JAMK University of Applied Sciences.

### **PROJECT DONE FOR THE EDUCATIONAL PURPOSE AND MODEL HAVE VERY BIG MAPE VALIDATION ERROR DUE TO DATA QUALITY ISSUES**
---

## Project Description

This application serves a web interface powered by **Flask** and uses a pre-trained **XGBoost** regression model to estimate the **price of solar panel modules** based on various input parameters.

While a `.h5` deep learning model (trained with TensorFlow) is included in the Docker image, it is **disabled by default**, as it consistently underperformed compared to the XGBoost model during evaluation.

---

## Modeling Approach

As part of the **AIDA project course** at JAMK University of Applied Sciences, this project explored a wide range of forecasting and regression strategies to identify the most effective method for solar panel price prediction. The development process included:

### Time Series Models

* **ARIMA**
* **Auto-regressive Decision Tree**
* **ElasticNet Auto-regression**

### Standard Regression Models

* **ElasticNet**
* **Decision Tree Regressor**
* **XGBoost Regressor** – Ultimately selected for deployment due to its accuracy and robustness.
* **Stacking Regressor** – An ensemble combining XGBoost → DecisionTree → LinearRegression.

### Deep Learning Models

* **Dense Neural Network** – Fully connected layers; included in the image but **not used in production**.
* **Transformer + LSTM Hybrid** – Tested for capturing long-term dependencies in time-series data.

---

## Features

* Web-based UI with Flask
* XGBoost model
* Dockerized for easy deployment

---

## Stack

| Component    | Version |
| ------------ | ------- |
| Python       | 3.10.16 |
| Flask        | 3.1.0   |
| XGBoost      | 3.0.0   |
| Scikit-learn | 1.6.1   |
| Pandas       | 2.2.3   |
| NumPy        | 1.26.4  |
| Joblib       | 1.4.2   |

---

## Docker

### Dockerfile

```dockerfile
FROM python:3.10.16
WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8080
CMD ["python3", "app/app.py"]
```

### Run the Container

```bash
docker run -p 8080:8080 wearecooked/pv-price-forecaster:alpha
```

The app will be available at:
**[http://localhost:8080](http://localhost:8080)**

---

## Development Notes

* The TensorFlow model (`model.h5`) is included in the image but not loaded in `app.py`.
  To enable it, modify the backend logic (commented out in the app.py, and install tensorflow==2.10.0) — though the XGB model offers better performance.

* The app currently runs in **Flask development mode**.

---

## Project Structure

```
.
├── app/
│   ├── app.py          # Flask backend
│   ├── templates/      # HTML templates
│   └── static/         # CSS
├── dumps/              # Models and other necessary things dumped with joblib
├── requirements.txt
└── Dockerfile
```

