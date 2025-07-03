# 💓 AI-Augmented Heart Monitoring using PCG and ECG Signals

This repository presents a complete MATLAB-based project focused on non-invasive detection of cardiovascular diseases (CVD), especially Coronary Artery Disease (CAD), using **Phonocardiogram (PCG)** and **Electrocardiogram (ECG)** signals. The system combines biomedical signal acquisition, preprocessing, feature extraction, and machine learning/deep learning for classification.

---

## 🧠 Project Objectives

- Acquire and preprocess PCG and ECG signals using digital sensors or open datasets.
- Apply signal processing techniques to remove noise and artifacts.
- Segment heart cycles for detailed feature analysis.
- Extract meaningful features from time and frequency domains.
- Classify between normal and abnormal heart conditions using ML/DL models.
- Enable scalable, cost-effective cardiovascular monitoring using AI.

---

## 📦 Features

- Bandpass and spike noise filtering
- PCG segmentation using Springer HSMM algorithm
- ECG preprocessing and RR interval analysis
- Feature extraction: PSD, LFCC, QRS width, etc.
- Classification using:
  - 🧮 Support Vector Machine (SVM)
  - 🤖 Convolutional Neural Networks (CNN)
- Noise cancellation using adaptive filters (NLMS, Wiener)
- MATLAB implementations for each step

---

## 🩺 Understanding ECG Signals

**Electrocardiogram (ECG)** is a biomedical signal that records the heart’s electrical activity over time. It is widely used in cardiac diagnostics due to its ability to detect arrhythmias, myocardial infarctions, conduction issues, and more.

### ⚡ ECG Waveform Components:
- **P wave** – Atrial depolarization (atria contract)
- **QRS complex** – Ventricular depolarization (ventricles contract)
- **T wave** – Ventricular repolarization (recovery phase)
- **RR interval** – Time between two heartbeats

---

### 🧪 ECG Processing in This Project:

1. **Acquisition**: From biosensors or open datasets  
2. **Preprocessing**: Noise filtering, baseline correction, normalization  
3. **Segmentation**: Detecting QRS peaks and separating heartbeats  
4. **Feature Extraction**:
   - Time-domain: RR intervals, QRS width
   - Frequency-domain: Fourier/wavelet features  
5. **Classification**: SVM, CNN, and hybrid models  

---

### 🚀 Why ECG + AI?

- Detects subtle, early-stage abnormalities
- Enables real-time, remote monitoring
- Ideal for wearable devices
- Reduces dependency on invasive procedures

---

## 📊 Applications

- Smart healthcare and telemedicine  
- Wearable heart monitoring systems  
- Automated cardiac risk screening  
- Post-operative cardiac tracking  

---

## 📁 Folder Structure

```plaintext
├── Day1/                        # Signal filtering, PSD, spike removal
├── Day2/                        # Feature extraction, CNN training
├── PCGSegment/                 # Springer segmentation code
├── adaptive_filter/            # NLMS & Wiener filter implementations
├── SPARC Workshop_slides.pdf   # Slide guide to all experiments
├── IET Workshop Pamphlet.pdf   # Event details
```
---


## 🛠️ Requirements
- MATLAB R2019b or later
- Signal Processing Toolbox
- Deep Learning Toolbox (for CNN training)
- Audio files and sample datasets

## 🖼️ ECG Signal Processing Presentation

Below are slides summarizing the fundamentals of ECG and its role in AI-based heart monitoring:


![Slide 1](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/1.jpg)
![Slide 2](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/2.jpg) 
![Slide 3](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/3.jpg) 
![Slide 4](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/4.jpg)
![Slide 5](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/5.jpg) 
![Slide 6](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/6.jpg) 
![Slide 7](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/7.jpg)
![Slide 8](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/8.jpg) 
![Slide 9](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/9.jpg) 
![Slide 10](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/10.jpg)
![Slide 11](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/11.jpg)
![Slide 12](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/12.jpg) 
![Slide 13](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/13.jpg) 
![Slide 14](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/14.jpg)
![Slide 15](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/15.jpg) 
![Slide 3](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/16.jpg) 
![Slide 1](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/1.jpg)
![Slide 2](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/2.jpg) 
![Slide 3](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/3.jpg) 
![Slide 1](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/1.jpg)
![Slide 2](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/2.jpg) 
![Slide 3](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/3.jpg) 



