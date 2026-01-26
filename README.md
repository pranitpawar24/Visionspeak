# 👁️ VisionSpeak  
### Multimodal Assistive AI for Visually Impaired Users  

<p align="center">
  <img src="https://img.shields.io/badge/Research-ICSIAIML%202025-00E5FF?style=for-the-badge&logo=googlescholar&logoColor=white"/>
  <img src="https://img.shields.io/badge/Published%20By-Atlantis%20Press-22D3EE?style=for-the-badge"/>
</p>

<p align="center">
  <a href="https://colab.research.google.com/drive/1MxlOW3HnhmLQzG0GWJCI7ebk4IwslfrW?usp=sharing">
    <img src="https://colab.research.google.com/assets/colab-badge.svg"/>
  </a>
</p>

---

## 📌 Overview

**VisionSpeak** is a **multimodal AI system** designed to bridge the gap between **visual information and audio feedback** for visually impaired users.

The system intelligently:
- Detects whether an image contains **text or non-textual visual content**
- Extracts and reads text aloud using **OCR**
- Generates **semantic image descriptions** when no text is present
- Converts outputs into **natural-sounding speech**

> 🎯 The core goal is **real-world usability**, not demo-based inference.

---

## 📄 Research & Publication

This project is published as a **peer-reviewed research paper** at:

> **International Conference on Smart Innovations in Artificial Intelligence and Machine Learning (ICSIAIML-25)**  
> **Publisher:** Atlantis Press, 2025  

🔗 **Paper Link:**  
https://www.atlantis-press.com/proceedings/icsiaiml-25/126021228

---

## ✨ Key Features

- 🔍 **Smart Detection Switch**  
  Automatically decides between OCR or visual captioning based on image content.

- 🧾 **Optical Character Recognition (OCR)**  
  High-accuracy text extraction using **PaddleOCR**  
  (supports printed + handwritten text).

- 🖼️ **Image Captioning**  
  Uses **BLIP (Bootstrapping Language-Image Pre-training)** to describe scenes with no text.

- 🔊 **Text-to-Speech (TTS)**  
  Converts extracted text or generated captions into audio using **Google Text-to-Speech (gTTS)**.

- 📷 **Dual Input Modes**  
  - Live webcam capture  
  - Static image upload  

---

## 🚀 Quick Start (Google Colab)

The fastest way to try VisionSpeak without setup:

👉 **Run directly in Google Colab:**  
https://colab.research.google.com/drive/1MxlOW3HnhmLQzG0GWJCI7ebk4IwslfrW?usp=sharing

✔ No installation  
✔ Browser-based camera support  
✔ Preconfigured environment  

---

## 💻 Local Installation

Run VisionSpeak locally on **Windows / macOS / Linux**.

### 🔧 Prerequisites
- Python **3.8+**
- Webcam (optional, for live capture)

---

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/pranitpawar24/VisionSpeak.git
cd VisionSpeak
