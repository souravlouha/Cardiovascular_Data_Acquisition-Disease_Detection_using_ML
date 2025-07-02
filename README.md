# 🫀 AI-Augmented Heart Monitoring using PCG and ECG Signals
This project presents a comprehensive framework for non-invasive detection of cardiovascular diseases (CVD), particularly Coronary Artery Disease (CAD), using Phonocardiogram (PCG) and Electrocardiogram (ECG) signals. The objective is to develop a reliable, low-cost diagnostic support system using signal processing and artificial intelligence (AI) techniques implemented in MATLAB.

The system begins with acquisition of heart signals using digital stethoscopes and ECG sensors placed on the body, either manually or via a wearable vest. These raw signals are then preprocessed through several steps including bandpass filtering, spike noise removal, and normalization to enhance signal quality and reduce clinical noise.

For segmentation, the project uses the Springer Hidden Semi-Markov Model (HSMM) to divide the PCG into four phases: S1, systole, S2, and diastole. Accurate segmentation allows extraction of meaningful cardiac cycles for further analysis.

The next stage involves feature extraction from both time and frequency domains. Power Spectral Density (PSD) and Linear Frequency Cepstral Coefficients (LFCC) are calculated to capture both spectral and temporal characteristics of the heart sounds. ECG features such as R-R intervals are also considered.

To classify normal and abnormal heart conditions, two approaches are used:

Classical Machine Learning: Support Vector Machine (SVM) with handcrafted features.

Deep Learning: Convolutional Neural Network (CNN) trained on spectrograms and other image representations of the signals.

Additionally, advanced noise cancellation is implemented using adaptive filtering techniques like NLMS and Wiener filters, utilizing reference microphones for environmental noise suppression.

The system has been tested on real clinical datasets and achieves promising accuracy, sensitivity, and specificity. It highlights the potential of AI in developing a portable, cost-effective cardiac pre-screening tool, especially beneficial for remote and underserved healthcare settings.
