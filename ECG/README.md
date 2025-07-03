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
├── seta.txt                           # ✅ Main ECG dataset used in all analysis
├── ECG01.m                            # 🔹 Final working file — clean ECG processing + output + proper legends
├── Scratch_ecg.m                      # 🔸 Pan-Tompkins Algorithm + QRS detection + Fiducial parameter extraction
├── augmented_pan_tom.m               # 🔸 T-wave and P-wave detection functions (augmentation added)
├── final_output_withPTQRS.png         # 📈 Final output plot showing P, QRS, T clearly
├── ecg graph.png                      # Raw ECG plot
├── ECG graph after LPF.png            # After Low Pass Filter
├── ECG of HPF.png                     # After High Pass Filter
├── Ecg graph after dc removal.png     # After DC drift removal
├── Derivative filter.png              # After derivative filtering
├── Graph after mwi.png                # After Moving Window Integration (MWI)
├── Subplot.png                        # Combined plot showing all processing stages
├── cardiomyopathy-20132-0009.-LEAD II_filtered.txt   # Another sample ECG dataset
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
![Slide 16](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/16.jpg) 
![Slide 17](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/17.jpg)
![Slide 18](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/18.jpg) 
![Slide 19](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/19.jpg) 
![Slide 20](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/20.jpg)
![Slide 21](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/21.jpg)
![Slide 22](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/22.jpg) 
![Slide 23](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/23.jpg) 
![Slide 24](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/24.jpg)
![Slide 25](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/25.jpg) 
![Slide 26](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/26.jpg) 
![Slide 27](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/27.jpg)
![Slide 28](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/28.jpg) 
![Slide 29](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/29.jpg) 
![Slide 30](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/30.jpg)
![Slide 31](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/31.jpg)
![Slide 32](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/32.jpg)
![Slide 33](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/33.jpg) 
![Slide 34](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/34.jpg) 
![Slide 35](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/35.jpg)
![Slide 36](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/36.jpg) 
![Slide 37](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/37.jpg) 
![Slide 38](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/38.jpg)
![Slide 39](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/39.jpg) 
![Slide 40](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/40.jpg) 
![Slide 41](https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/ECG_presentation/41.jpg)

























