# 🚀 Ultimate WordPress Security Scanner & Exploitation Tool

<div align="center">

![WordPress Security](https://img.shields.io/badge/WordPress-Security%20Scanner-blue)
![Python](https://img.shields.io/badge/Python-3.8%2B-green)
![Multi-Threaded](https://img.shields.io/badge/Multi--Threaded-30%20threads-orange)
![License](https://img.shields.io/badge/License-MIT-red)

**Advanced WordPress vulnerability scanner with automatic exploitation and shell upload capabilities**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Screenshots](#-screenshots) • [Disclaimer](#-disclaimer)

</div>

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Installation](#-installation)
- [Usage](#-usage)
- [Exploitation Modules](#-exploitation-modules)
- [Output Files](#-output-files)
- [Screenshots](#-screenshots)
- [Disclaimer](#-disclaimer)
- [Legal Notice](#-legal-notice)

## 🎯 Overview

**Ultimate WordPress Security Scanner** is a comprehensive penetration testing tool designed for security professionals to assess WordPress installations. It combines multiple attack vectors including vulnerability scanning, credential brute-forcing, and automatic shell deployment.

### 🔍 Key Capabilities

- **Advanced WordPress Detection** - 9 different detection methods
- **Multi-Vector Exploitation** - 15+ different WordPress vulnerabilities
- **Smart Credential Generation** - Domain-based password intelligence
- **Automatic Shell Upload** - 4 different upload methods
- **Real-time Verification** - Active shell and admin access confirmation

## ✨ Features

### 🔎 Detection & Reconnaissance
- ✅ Advanced WordPress fingerprinting (9 methods)
- ✅ Username enumeration via Author ID & REST API
- ✅ Plugin and theme version detection
- ✅ DNS resolution with WWW fallback
- ✅ Smart header rotation for evasion

### 💥 Exploitation Modules
- ✅ **WP File Manager** (CVE-2020-25213)
- ✅ **Elementor** (CVE-2022-XXXXX)
- ✅ **Duplicator** (CVE-2020-11738)
- ✅ **WPForms** file upload vulnerability
- ✅ **ProfilePress** privilege escalation
- ✅ **Ultimate Member** admin registration
- ✅ **Password Reset Poisoning**
- ✅ **Host Header Injection**
- ✅ And 8+ more vulnerabilities...

### 🔐 Authentication Bypass
- ✅ Smart brute force with domain intelligence
- ✅ @domain password generation technique
- ✅ Username extraction from multiple sources
- ✅ Session management and cookie handling
- ✅ Admin panel verification with 6 validation methods

### 🐚 Post-Exploitation
- ✅ Automatic shell upload (4 methods)
- ✅ Shell verification with multiple checks
- ✅ Real-time shell activity monitoring
- ✅ Organized result storage
- ✅ Session persistence

## 🛠 Installation

### Prerequisites

```bash
# Python 3.8 or higher required
python --version

# Install required dependencies
pip install requests colorama urllib3
```

### Quick Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/ultimate-wp-scanner.git
cd ultimate-wp-scanner

# Create necessary directories
mkdir -p Files readyTouse

# Add required shell files to Files/ directory
# - Files/plugin.zip (WordPress plugin with shell)
# - Files/theme.zip (WordPress theme with shell) 
# - Files/index.php (Web shell)
```

### Required Files Structure

```
ultimate-wp-scanner/
├── BRUTER.py                 # Main scanner
├── Files/
│   ├── plugin.zip           # Malicious plugin with shell
│   ├── theme.zip            # Malicious theme with shell
│   └── index.php            # Web shell payload
└── readyTouse/              # Auto-created output directory
```

## 🚀 Usage

### Basic Scanning

```bash
python BRUTER.py targets.txt
```

### Input File Format

Create `targets.txt` with one site per line:

```
example.com
https://site.com
http://192.168.1.100
subdomain.target.com
```

### Advanced Options

The tool automatically configures:
- **30 concurrent threads**
- **Smart rate limiting**
- **DNS resolution with fallback**
- **Automatic output organization**

## 💥 Exploitation Modules

### 1. Plugin Vulnerabilities

| Plugin | CVE | Impact |
|--------|-----|---------|
| WP File Manager | CVE-2020-25213 | RCE via File Upload |
| Elementor | CVE-2022-XXXXX | Privilege Escalation |
| Duplicator | CVE-2020-11738 | Unauthenticated RCE |
| WPForms | - | Arbitrary File Upload |
| ProfilePress | CVE-2023-27910 | Password Reset Abuse |

### 2. Authentication Attacks

```python
# Smart credential generation
username@domain.com
admin@domain123
domain@domain
# Plus 60+ intelligent variations
```

### 3. Shell Deployment Methods

1. **Plugin Upload** - Via WordPress plugin installer
2. **Theme Upload** - Via WordPress theme installer  
3. **File Manager** - Via WP File Manager plugin
4. **Theme Editor** - Direct file modification

## 📁 Output Files

The tool creates organized results in `readyTouse/` directory:

| File | Description |
|------|-------------|
| `successfully_logged_WordPress.txt` | Valid credentials |
| `Shells.txt` | Active web shells |
| `credentials_found.txt` | Extracted credentials |
| `wordpress_exploits.txt` | Successful exploit results |
| `vulnerabilities.txt` | Detected vulnerabilities |
| `host_header_injection.txt` | Host header attack results |

## 📸 Screenshots

### Dashboard Interface
```
┌─────────────────────────────────────────────────────────┐
│ ULTIMATE WORDPRESS CHECKER v3.0 - FINAL EDITION         │
│                 WITH SHELL UPLOAD                       │
├─────────────────────────────────────────────────────────┤
│ [+] Sites Loaded      : 150                             │
│ [+] Threads           : 30                              │
│ [+] Username Extract  : ENABLED (Author ID + REST API)  │
│ [+] Smart Headers     : ENABLED (Anti-Ban)              │
│ [+] Shell Upload      : ENABLED (4 Methods)             │
└─────────────────────────────────────────────────────────┘
```

### Exploitation Progress
```
 -| https://target.com --> [WordPress Confirmed! Indicators: wp-login.php, wp-admin, readme.html]
 -| https://target.com --> [WP File Manager vulnerable - v6.8]
 -| https://target.com --> [SHELL VERIFIED AND SAVED: https://target.com/wp-content/plugins/wp-file-manager/lib/files/shell.php]
 -| https://target.com --> [SHELL UPLOADED!]
```

### Results Summary
```
┌─────────────────────────────────────────────────────────┐
│                 FINAL STATISTICS                        │
├─────────────────────────────────────────────────────────┤
│ [*] Total Sites         : 150                           │
│ [*] Wordpress Found     : 120                           │
│ [*] Usernames Found     : 85                            │
│ [+] Successful          : 45                            │
│ [+] Shells Uploaded     : 28                            │
│ [X] Failed              : 75                            │
│ [*] Success Rate        : 37.5%                         │
└─────────────────────────────────────────────────────────┘
```

## ⚠ Disclaimer

**THIS TOOL IS FOR EDUCATIONAL AND AUTHORIZED SECURITY TESTING ONLY**

> 🚨 **Important Legal Notice**: This tool is designed for:
> - Legitimate penetration testing with explicit permission
> - Security research and education
> - Authorized vulnerability assessment
> - Security awareness training

**Illegal use of this tool is strictly prohibited.** The developers are not responsible for any misuse or damage caused by this tool.

### Legal Requirements

- ✅ Obtain written permission before scanning
- ✅ Follow responsible disclosure practices
- ✅ Comply with local laws and regulations
- ✅ Use only on systems you own or have authorization to test

## 🔒 Security Recommendations

For WordPress administrators, we recommend:

1. **Keep plugins and themes updated**
2. **Use strong, unique passwords**
3. **Implement two-factor authentication**
4. **Regular security audits**
5. **Web application firewall**
6. **Limit login attempts**

## 📞 Support

For issues and feature requests:
1. Check the existing issues on GitHub
2. Provide detailed error logs
3. Include target environment information

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

<div align="center">

**Use Responsibly • Stay Ethical • Secure the Web**

*Made with ❤️ for the security community*

</div>
