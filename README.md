 # 🫀 AI-Augmented Heart Monitoring using ECG, PCG, and PPG Signals

This project provides a complete, AI-based system for **non-invasive detection of cardiovascular diseases (CVD)** by analyzing a combination of physiological signals — namely **Electrocardiogram (ECG)**, **Phonocardiogram (PCG)**, and **Photoplethysmogram (PPG)**. By integrating signal processing, feature engineering, and machine learning (ML), this framework enables early diagnosis of conditions like **Coronary Artery Disease (CAD)**, **arrhythmias**, **valvular defects**, and **vascular dysfunctions**.

---

## 🌐 Motivation

Cardiovascular diseases remain the **leading cause of death globally**. However, traditional diagnostic tools such as echocardiograms, angiograms, and stress tests are:
- Costly
- Not portable
- Often inaccessible in rural/remote areas

This project aims to address this gap by developing a **low-cost, scalable, AI-driven diagnostic tool** that can work with **wearable sensors**, **digital stethoscopes**, or **simple optical devices** to collect biosignals and analyze them using smart algorithms.

---

## 🧠 System Overview

### 📥 1. Signal Acquisition

The system works on three physiological signals:
- **ECG (Electrical)**: Captures electrical impulses of the heart via electrodes placed on the skin (Lead II).
- **PCG (Acoustic)**: Captures heart sounds through a digital stethoscope, usually stored as `.wav` files.
- **PPG (Optical)**: Measures changes in blood volume via light absorption using infrared LEDs (smartwatches, pulse oximeters).

These signals are either recorded in real-time using biomedical hardware or taken from publicly available datasets.

---

### 🧹 2. Preprocessing

All raw signals are cleaned and filtered to ensure quality before analysis.

#### ECG:
- DC offset removal
- Bandpass filtering (0.5–100 Hz)
- High-pass & low-pass filtering
- Normalization

#### PCG:
- Bandpass filtering (20–950 Hz)
- Spike noise removal
- Amplitude normalization

#### PPG:
- Baseline wander correction
- Motion artifact filtering
- Moving average smoothing

✅ **Why this is important**: Noise can obscure important clinical information like murmurs or QRS complexes. Preprocessing improves both human and AI interpretability.

---

### 🧩 3. Segmentation & Fiducial Point Detection

#### ECG:
- **Pan-Tompkins algorithm** detects QRS complexes
- Additional logic used to locate P and T waves
- RR intervals and waveform intervals extracted

#### PCG:
- Uses **Springer Hidden Semi-Markov Model (HSMM)** to segment into S1 → Systole → S2 → Diastole
- Clear isolation of murmurs and valve sounds

#### PPG:
- Peaks, Dicrotic Notch, and Diastolic end points detected
- Used for **Pulse Rate Variability (PRV)** analysis (analogous to HRV from ECG)

🧠 These fiducial points are crucial for extracting **clinical-grade features**.

---

### 📊 4. Feature Extraction

The extracted features fall into three domains:

#### 🔹 Time-Domain Features:
- RR Interval (ECG)
- Heart Rate (PPG)
- Systolic and Diastolic duration (PCG)
- Pulse Transit Time (ECG + PPG combined)

#### 🔹 Frequency-Domain Features:
- Power Spectral Density (PSD)
- Band energy in specific ranges
- Heart sound energy distribution (PCG)

#### 🔹 Cepstral/Statistical Features:
- Linear Frequency Cepstral Coefficients (LFCC)
- Skewness, Kurtosis, Variance
- Slope and Area under the curve

All features are normalized and compiled into feature matrices for model training.

---

### 🤖 5. Machine Learning & Deep Learning Models

#### ✅ Classical ML Models:
- **Support Vector Machine (SVM)**
- **Decision Trees / Random Forest**
- **K-Nearest Neighbors (KNN)**

These models work well with engineered features like PSD or RR intervals.

#### 🚀 Deep Learning:
- **1D CNNs**: Learn from raw waveforms directly (especially ECG/PPG)
- **2D CNNs**: Trained on spectrogram images (for PCG/PPG)
- **LSTM/GRU (optional)**: For time series classification (sequential waveforms)

#### 🔁 Hybrid Approach:
- Combines ECG + PPG or ECG + PCG for improved diagnostic accuracy
- Feature fusion or late-stage ensemble learning

---

### 📏 6. Model Evaluation Metrics

Each classifier is evaluated on:
- **Accuracy**
- **Sensitivity (Recall)** – true positive rate
- **Specificity** – true negative rate
- **Precision and F1-Score**
- **ROC Curve and AUC**

This ensures models are **clinically reliable** and not just technically accurate.

---

## 🎯 Clinical Use Cases & Applications

| Application               | Signal(s) Used | Model Type | Outcome |
|---------------------------|----------------|------------|---------|
| CAD Detection             | PCG + ECG      | SVM / CNN  | 75–85% Accuracy |
| Murmur Identification     | PCG            | LFCC + CNN | 80%+ Sensitivity |
| Arrhythmia Detection      | ECG            | Pan-Tompkins + CNN | Real-time QRS classification |
| Pulse Monitoring / PRV    | PPG            | Time-domain ML | Wellness analytics |
| Wearable Health Alerts    | ECG + PPG      | Ensemble   | Real-time abnormal alert |

---

## 🔬 Technical Stack

- **MATLAB** (Signal processing, ML training, visualization)
- **.wav / .txt / .mat** file support
- **Custom plotting** for ECG/PCG/PPG annotation
- **Adaptive filters** (NLMS, Wiener)
- **Springer segmentation model for PCG**

---

## 📁 Repository Structure

```plaintext
├── ECG/            # ECG signal processing: Pan-Tompkins, plots, QRS detection
├── PCG/            # PCG segmentation and LFCC-based feature extraction
├── PPG/            # PPG peak detection, notch detection, PRV extraction
├── ML_models/      # Trained SVM, CNN scripts
├── Output_images/  # Visual plots of each signal and step
├── README.md       # Full documentation

```
-----------------

## 🛠️ Signal Processing Workflow

### ① ECG Signal (Electrocardiogram)
- **Pan-Tompkins algorithm** used for QRS detection  
- Filtering (low-pass, high-pass, derivative)  
- Squaring & MWI (Moving Window Integration)  
- Final output includes annotated P, QRS, T waves  

**Files:** `/ECG/ECG01.m`, `/Output_images/final_output_withPTQRS.png`

---

### ② PCG Signal (Heart Sounds)
- Springer HSMM for segmentation into S1–S2 cycle  
- Mel Spectrogram generation for audio signals  
- LFCC features for murmur classification  

**Files:** `/PCG/*.wav`, `/PCG/PCGSegment.m`, `/PCG/runSpringerSegmentationAlgorithm.m`

---

### ③ PPG Signal (Optical)
- Bandpass filtering  
- Peak, notch, and end diastolic point detection  
- Features: HR, PRV, dicrotic notch timing  

**Files:** `/PPG/PPG01.m`, `/PPG/Output_images/*.png`

---
## 🤖 AI/ML Model Pipeline

### CNN Model (for PCG Mel Spectrograms)

```python
model = Sequential([
    Conv1D(32, 5, activation='relu'),
    MaxPooling1D(2),
    Conv1D(64, 5, activation='relu'),
    MaxPooling1D(2),
    Conv1D(128, 3, activation='relu'),
    GlobalAveragePooling1D(),
    Dense(128, activation='relu'),
    Dropout(0.4),
    Dense(5, activation='softmax')
])
```

---------------

- **Input shape:** `(24, 64)`  
- **Classes:** `artifact`, `aunlabelledtest`, `extrahls`, `murmur`, `normal`  
- **Training Samples:** 140  
- **Testing Samples:** 36 
------

### 🧪 Evaluation Summary
- **Test Accuracy:** ` 61.11%`
- **Class Imbalance Affects Performance**

### Confusion Matrix:
  ```
      [[5, 3, 0, 0, 0],
      [2, 6, 1, 0, 2],
      [0, 1, 0, 0, 3],
      [0, 1, 0, 5, 1],
      [0, 0, 0, 0, 6]]
```
<img src="https://github.com/user-attachments/assets/4b619738-e0cd-42c1-a785-0d36839532ff" width="700"/>



--- 
### Classification Report:
```
                    precision   recall   f1-score    support

       artifact       0.71      0.62      0.67         8
aunlabelledtest       0.55      0.55      0.55        11
       extrahls       0.00      0.00      0.00         4
         murmur       1.00      0.71      0.83         7
         normal       0.50      1.00      0.67         6

        accuracy                           0.61        36
       macro avg       0.55      0.58      0.54        36
    weighted avg       0.60      0.61      0.59        36
```
----

## 🔍 Murmur Detection & Segmentation

- PCG signal is segmented in **0.2 second energy windows**
- High-energy regions are treated as potential murmurs
- Visualized with **ellipse overlays** to highlight:
  - `a → b`: duration of murmur
  - `a → c`: delay to peak
  - `c → d`: murmur amplitude (baseline to peak)
- **Output visualization:** `murmur_analysis_graph.jpg`

---

## 🧬 Signal Type Comparison

| Signal | Captures             | Sensor Type          | Use Case                         |
|--------|----------------------|----------------------|----------------------------------|
| **ECG**    | Electrical activity  | Electrodes           | QRS detection, HRV, PRV analysis |
| **PCG**    | Heart sounds         | Microphone/Steth     | Murmur classification, S1/S2     |
| **PPG**    | Blood volume changes | IR-based Optical     | Pulse rate, vascular health      |

---

## 🏥 Clinical Applications

- Early screening for:
  - Coronary Artery Disease (CAD)
  - Aortic Sclerosis
  - Hypertrophic Obstructive Cardiomyopathy (HOCM)
- **Wearable health systems**: smartwatches, stethoscope dongles
- Suitable for **remote and low-resource** healthcare environments
- Enables **telemedicine and home-based diagnostics**


















  
