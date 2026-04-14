# 🤝 Contributing to the Solutions Repository

Thank you for your interest in contributing!  
We warmly welcome community contributions to help grow and improve this collection of **Solutions** for the OPC Router and connubes.

This repository exists so that users and partners can share reusable, well‑structured Solutions that others can benefit from.  
Whether you're contributing a small fix, a new Solution, or improvements to documentation — your help is appreciated.

---

## 📌 How to Contribute

Before submitting a contribution, please read the guidelines below.  
These ensure that all Solutions remain consistent, discoverable, and usable within the product workflows.

### 1. Fork and Prepare Your Changes

- Fork the repository  
- Create a feature branch for your contribution  
- Add or modify content following the rules below

### 2. Submit a Pull Request

- Open a pull request with a clear description of your changes  
- If contributing a new Solution, ensure all required files are included

A maintainer will review your submission and may request adjustments.

A guide on how to create your own Solutions can be found in the [Documentation](https://docs.opc-router.com/solution_gallery/create/).

---

## 📐 Contribution Rules

### **Solution Structure Requirements**

- Each Solution must be placed in its own folder  
- The **configuration files must be located in a `config` subdirectory**, mirroring the structure used by the products
  - For reference you can take a look at the Solutions in this Repository
- Each Solution must include a `solution.yaml` file

### Metadata and Parameter Requirements

- `solution.yaml` must contain all required fields  
- Parameters must follow consistent naming conventions  
- Default values must be meaningful and safe for users

### General Requirements

- No deactivated or unused connections may be present  
- No unused plug-ins may be present  
- Icons must have sufficient resolution (minimum **512×512 px**) or be provided in **SVG format**

### Quality and Review

- Solutions should be tested before submission  
- Folder names, files, and descriptions must be clear and unambiguous  
- Pull requests must clearly explain the purpose and scope of the contribution
