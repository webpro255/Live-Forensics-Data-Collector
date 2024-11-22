![GitHub last commit](https://img.shields.io/github/last-commit/webpro255/Rapid-Response-Forensics-Toolkit)
![GitHub issues](https://img.shields.io/github/issues/webpro255/Rapid-Response-Forensics-Toolkit)
![GitHub license](https://img.shields.io/github/license/webpro255/Rapid-Response-Forensics-Toolkit)
![GitHub forks](https://img.shields.io/github/forks/webpro255/Rapid-Response-Forensics-Toolkit)

# Rapid Response Forensics Toolkit 🛡️🚀

An innovative solution for live Linux system investigations, the **Rapid Response Forensics Toolkit** empowers forensic analysts to capture volatile data swiftly and securely. My unique approach leverages in-memory script execution to minimize system footprint, ensuring the integrity and admissibility of collected evidence.

## Unique Advantages

- **Memory-Resident Execution:** Our scripts run directly from RAM, a distinctive method that sets this toolkit apart by reducing disk I/O on the target system.
- **Zero Footprint Philosophy:** Designed with a forensic-first mindset, we prioritize leaving the smallest possible trace on the investigated system.
- **Modular Design:** Easily extend the toolkit with additional modules to capture specific data relevant to your investigation.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Scripts Explained](#scripts-explained)
- [Legal and Ethical Considerations](#legal-and-ethical-considerations)
- [Contributing](#contributing)
- [License](#license)


## Introduction

**Rapid Response Forensics Toolkit is a Live Forensics Data Collector** 
a powerful and automated Bash script toolkit designed for digital forensic professionals. It securely captures critical volatile data from live Linux systems with minimal interaction, ensuring data integrity and adherence to forensic best practices.

**This toolkit is essential for**:
- Incident response teams
- Cybersecurity analysts
- Digital forensic investigators


## Features

- **Automated Execution:** Streamlines data collection with a single command.
- **Secure Data Handling:** Executes scripts from memory to avoid altering the suspect system.
- **Comprehensive Data Collection:** Gathers network information, running processes, user sessions, and more.
- **Integrity Verification:** Generates SHA256 hashes for all collected data.
- **Minimal System Impact:** Designed to minimize writes to the system, preserving evidence integrity.

## Getting Started

### Prerequisites

- A write-protected USB drive labeled `FORENSICS_USB`.
- Root (`sudo`) access on the target Linux system.

### Preparation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/webpro255/Rapid-Response-Forensics-Toolkit.git
   ```

   ## Getting Started

### Prerequisites
- A write-protected USB drive labeled `FORENSICS_USB`.
- Root (`sudo`) access on the target Linux system.

2. **Copy Scripts to USB Drive**:
Copy `collect_forensic_data.sh` and `run_forensics.sh` to the root directory of your write-protected USB drive.

3. **Label Your USB Drive**:
Ensure your USB drive is labeled `FORENSICS_USB` for the scripts to recognize it.


## Usage

1. **Insert the USB Drive into the Target System.**

2. **Open a Terminal and Navigate to the USB Drive:**

   ```bash
   cd /media/$USER/FORENSICS_USB
   ```
3. Run the Master Script:
 ```sudo bash run_forensics.sh```
4. Wait for Completion:

The script will execute and display progress messages. Do not interrupt the process.

5. Safely Remove the USB Drive:

After completion, unmount and remove the USB drive.
Note: Ensure you have legal authorization to perform these actions.


## Scripts Explained

### collect_forensic_data.sh

- **Purpose:** Collects volatile data from the system and saves it to the mounted USB drive.
- **Data Collected:**
  - System time and uptime
  - Logged-in users and session history
  - Network configurations and active connections
  - Running processes and open files
  - System information and configurations
  - Firewall rules and security settings
  - Generates SHA256 hashes for all collected files

### run_forensics.sh

- **Purpose:** Automates the mounting of the USB drive and execution of the `collect_forensic_data.sh` script with minimal interaction.
- **Process:**
  - Mounts the USB drive as read-only.
  - Copies the data collection script to RAM (`/dev/shm`).
  - Executes the script from RAM to minimize disk writes.
  - Unmounts the USB drive and cleans up temporary files.
 

## Legal and Ethical Considerations

**Important Notice:**

The **Rapid Response Forensics Toolkit** is intended for **educational purposes, training, and authorized testing environments only**. This toolkit is **not** intended for use in official forensic investigations or any situation where the legal admissibility of evidence is required.

- **Use of Standard Tools Recommended:** For official forensic investigations, it is recommended to use widely accepted and validated forensic tools that are recognized by the industry and legal system. This ensures compliance with legal standards and maintains the integrity and admissibility of collected evidence.

- **Tool Validation:** This toolkit is a custom script and has not been formally validated or certified for forensic accuracy. It may not collect all necessary data or function consistently across different systems.

- **No Warranty or Guarantee:** The toolkit is provided "as is," without any warranty of any kind, express or implied. The developer does not guarantee that the toolkit is free of errors or that it will meet any specific requirements.

- **Legal Compliance:** Users are responsible for ensuring that their use of this toolkit complies with all applicable laws, regulations, and organizational policies. Unauthorized access to systems or data is illegal and unethical.

- **Ethical Use Only:** This toolkit should be used responsibly and ethically. Do not use it to collect data from systems you do not own or do not have explicit permission to investigate.

- **Liability Disclaimer:** The developer is not liable for any damages, legal consequences, or losses arising from the use of this toolkit.

**By using the Rapid Response Forensics Toolkit, you agree to these terms and acknowledge that you understand the limitations and appropriate use of this toolkit.**



**Disclaimer:**

This toolkit is intended for use by authorized personnel in lawful forensic investigations. Unauthorized use or execution of these scripts on systems without explicit permission is illegal and unethical.

- Always ensure compliance with applicable laws and regulations.
- Obtain proper authorization before conducting any forensic activities.
- Handle all data responsibly and maintain confidentiality.

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please open an issue or submit a pull request.

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/NewFeature`).
3. Commit your changes (`git commit -am 'Add a new feature'`).
4. Push to the branch (`git push origin feature/NewFeature`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


Feel free to reach out for questions or collaboration opportunities.





   


