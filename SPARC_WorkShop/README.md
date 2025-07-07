# Scheme for Promotion of Academic and Research Collaboration **(SPARC)**
- **Cardiovascular_Data_Acquisition-Disease_Detection_using_ML**
-  **Multichannel Signal Processing and Classification of Phonocardiogram and Electrocardiogram**
-  **AI augmented heart monitoring using PCG and ECG signals**



-----------



# 🧠 SPARC Workshop: Multichannel Signal Processing and Classification of PCG & ECG

This repository is a part of the **SPARC (Scheme for Promotion of Academic and Research Collaboration)** initiative and presents a hands-on approach to cardiac health monitoring using **Phonocardiogram (PCG)** and **Electrocardiogram (ECG)** signals. The aim is to teach and build a complete biomedical signal processing and classification pipeline using real-world clinical data, MATLAB, and machine learning techniques.

---

## 🎯 Objective

To design and implement a framework that enables:

- Accurate segmentation of PCG signals into heart cycle phases (S1, systole, S2, diastole)
- Extraction of meaningful features from PCG and ECG
- Application of machine learning classifiers (SVM, CNN) to detect cardiac abnormalities
- Enhancement of signal quality through filtering and noise cancellation

This helps in early diagnosis of diseases such as **Coronary Artery Disease (CAD)**, **Hypertrophic Cardiomyopathy (HOCM)**, and more.

---

## 🗂️ Project Breakdown

### 🗓️ Day 1: Signal Preprocessing & Segmentation

- **Signal Acquisition**: Multiple PCG recordings are collected (`1vCAD.wav`, `normal.wav`, etc.)
- **Noise Removal**: Spike removal (Schmidt), Butterworth filters (low/high-pass), normalization
- **Segmentation**: Using **Springer Hidden Semi-Markov Model (HSMM)** via `runSpringerSegmentationAlgorithm.m`
  - Inputs include HSMM priors: `Springer_B_matrix`, `pi_vector`, `obs_distribution`
- **Envelope Extraction**: Hilbert transform and Homomorphic envelope
- **Feature Extraction**: PSD, wavelet, statistical metrics for classification

### 🗓️ Day 2: Machine Learning Classification

- **Feature Engineering**: Extracted features from PCG (`getSpringerPCGFeatures.m`)
- **Data Preparation**: Labeled dataset saved in `PCG_database.mat`
- **Model Training**:
  - **SVM** using `Feature_Extraction_and_SVM.m`
  - **CNN** using pre-processed input (`CNN_1input.mat`) and script (`CNN_1input_DataGenerated.m`)
- **Evaluation**: Accuracy, precision, recall, F1 using `calculate_metrics.m`

### 🎛 Adaptive Filtering

Experiments (`Expr8.m`, `Expr10.m`, etc.) for adaptive noise cancellation using LMS/NLMS filters to clean audio and heart sounds.

### 📊 Presentation Slides

Located in `Presentation/`, the full workshop slide deck (112 slides) visually explains every module, theory, and code overview.

---

## 💻 Technologies Used

- **MATLAB** for signal processing and model implementation
- **Springer HSMM** for heart sound segmentation
- **SVM & CNN** for classification
- **Wavelet & PSD** for feature engineering

---

# 📁 Folder & File Structure – SPARC_WorkShop
```
SPARC_WorkShop/                             # Root project folder for SPARC workshop
|
├── Day1/                                   # Day 1 content: Signal acquisition, denoising, segmentation
│   |
│   ├── PCGSegment/                         # Contains .wav files (PCG recordings) and PCG segmentation zip
│   │   ├── 1vCAD.wav                        # PCG audio file representing a CAD patient
│   │   ├── 2vCAD.wav                        # PCG audio file representing a CAD patient
│   │   ├── 3vCAD.wav                        # Another PCG example for classification
│   │   ├── breathing.wav                    # Audio file for noise handling example
│   │   ├── hospital.wav                     # Sample of hospital environment noise
│   │   ├── normal.wav                       # Normal heart sound audio sample
│   │   ├── PCGSegment.zip                   # Zipped version of segmentation scripts and assets
│   |
│   ├── butterworth_high_pass_filter.m      # MATLAB script to apply high-pass Butterworth filter
│   ├── butterworth_low_pass_filter.m       # MATLAB script to apply low-pass Butterworth filter
│   ├── Hilbert_Envelope.m                  # Computes envelope of signal using Hilbert transform
│   ├── Homomorphic_Envelope_with_Hilbert.m # Computes homomorphic envelope via Hilbert method
│   ├── Springer_B_matrix.mat               # HSMM parameter: observation probability matrix
│   ├── Springer_pi_vector.mat              # HSMM parameter: initial state probabilities
│   ├── Springer_total_obs_distribution.mat # HSMM parameter: total observation model
│   ├── default_Springer_HSMM_options.m     # Default config setup for HSMM model segmentation
│   ├── expand_qt.m                         # Utility to expand Q and T wave segments (if needed)
│   ├── getDWT.m                            # Discrete Wavelet Transform feature extraction function
│   ├── getHeartRateSchmidt.m               # Estimate heart rate using Schmidt method
│   ├── getSpringerPCGFeatures.m            # Extract features using Springer segmentation logic
│   ├── get_PSD_feature_Springer_HMM.m      # Extracts power spectral density features from PCG
│   ├── get_duration_distributions.m        # Generates duration distribution for HSMM states
│   ├── normalise_signal.m                  # Normalizes input signals to standard scale
│   ├── runSpringerSegmentationAlgorithm.m  # Main HSMM segmentation algorithm implementation
│   ├── schmidt_spike_removal.m             # Script to remove spikes from signal using Schmidt method
│   ├── viterbiDecodePCG_Springer.m         # Applies Viterbi decoding for optimal state sequence in PCG
│   └── PSDseg.m                            # Computes PSD-based segmentation or features
|
├── Day2/                                   # Day 2 content: Feature extraction and ML-based classification
│   ├── CNN_1input.mat                      # Preprocessed data formatted for CNN input
│   ├── CNN_1input_DataGenerated.m         # MATLAB code that generated CNN input from raw data
│   ├── Feature_Extraction_and_SVM.m       # SVM-based classifier and feature processing pipeline
│   ├── PCG_database.mat                   # Dataset containing PCG samples and labels
│   └── calculate_metrics.m                # Script to compute evaluation metrics (accuracy, F1, etc.)
|
├── Presentation/                          # Workshop slides (112 in total)
│   └── SPARC_Workshop_slides-001.png ...  # All slide images to document workshop learning
|
├── adaptive_filter/                       # Experiments related to Adaptive Noise Cancellation
│   ├── Expr8.m                             # Experiment 8: basic filtering setup
│   ├── Expr10.m                            # Experiment 10: filter performance tuning
│   ├── Expr11.m                            # Experiment 11: real-time filtering test
│   └── Expr12.m                            # Experiment 12: combined filter evaluation
|
├── .gitattributes                         # Git attributes file for line endings or binary files
├── README.md                              # Main documentation file (describes repo purpose and usage)

```

---

## 📌 Outcome & Significance

This project demonstrates the end-to-end design of an AI-augmented heart monitoring system. The methodology is applicable in:

- **Cardiovascular Screening** in rural and remote settings
- **Smart Stethoscope & Wearable Devices** for real-time analysis
- **Academic Research** and student training

The integration of **PCG and ECG signal intelligence** with **machine learning** ensures a practical foundation for building low-cost, non-invasive cardiac diagnostic tools.

---

## 🙌 Acknowledgement

This work is supported by **SPARC, Ministry of Education, Govt. of India** and conducted in collaboration with academic institutions under the biomedical engineering and AI initiative.

Let us know if you'd like real-time demos, additional datasets, or Python conversions!



-------


<!-- Generated HTML embed with width="950" -->
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-001.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-002.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-003.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-004.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-005.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-006.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-007.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-008.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-009.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-010.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-011.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-012.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-013.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-014.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-015.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-016.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-017.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-018.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-019.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-020.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-021.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-022.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-023.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-024.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-025.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-026.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-027.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-028.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-029.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-030.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-031.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-032.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-033.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-034.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-035.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-036.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-037.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-038.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-039.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-040.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-041.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-042.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-043.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-044.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-045.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-046.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-047.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-048.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-049.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-050.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-051.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-052.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-053.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-054.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-055.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-056.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-057.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-058.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-059.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-060.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-061.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-062.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-063.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-064.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-065.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-066.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-067.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-068.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-069.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-070.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-071.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-072.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-073.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-074.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-075.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-076.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-077.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-078.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-079.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-080.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-081.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-082.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-083.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-084.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-085.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-086.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-087.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-088.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-089.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-090.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-091.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-092.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-093.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-094.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-095.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-096.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-097.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-098.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-099.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-100.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-101.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-102.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-103.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-104.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-105.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-106.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-107.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-108.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-109.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-110.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-111.png" width="950"/>
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/SPARC_WorkShop/Presentation/SPARC%20Workshop_slides-112.png" width="950"/>


















