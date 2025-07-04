## 📈 ECG Signal Processing Workflow (Step-by-Step)

---

### 🟢 First Plot: Original ECG Signal  
This is the raw ECG signal plotted before any preprocessing.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/ecg%20graph.png" width="700"/>

---

### 🔹 Step 1: DC Offset Removal  
Removes baseline drift from the ECG to center the waveform.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/Ecg%20graph%20after%20dc%20removal.png" width="700"/>

---

### 🔹 Step 2: Normalization  
Scales the signal amplitude for consistent processing. *(Image shown in Step 1 combined)*

---

### 🔹 Step 3: Low-Pass Filtering (LPF)  
Removes high-frequency noise while preserving QRS complex.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/ECG%20graph%20after%20LPF.png" width="700"/>

---

### 🔹 Step 4: High-Pass Filtering (HPF)  
Eliminates low-frequency noise such as motion artifacts.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/ECG%20of%20HPF.png" width="700"/>

---

### 🔹 Step 5: Derivative Filter  
Highlights steep slopes in the QRS complex for better detection.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/Derivative%20filter.png" width="700"/>

---

### 🔹 Step 6: Squaring Function  
Emphasizes large values (QRS peaks) and suppresses smaller ones. *(Not visualized separately)*

---

### 🔹 Step 7: Moving Window Integration (MWI)  
Smooths the signal using a window to extract QRS energy.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/Graph%20after%20mwi.png" width="700"/>

---

### 🟥 Step 8: QRS Region Detection using Pan-Tompkins Algorithm  
Final detection of QRS complexes including annotations for P, QRS, and T waves.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/final_output_withPTQRS.png" width="700"/>

---

### 🔸 Final Subplot: Combined View of All Processing Stages  
Multiple stages of filtering and feature extraction in one visualization.  
<img src="https://github.com/souravlouha/Cardiovascular_Data_Acquisition-Disease_Detection_using_ML/blob/main/ECG/Output_images/Subplot.png" width="700"/>
