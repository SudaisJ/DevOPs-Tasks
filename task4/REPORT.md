# Week 4: Container Security Report

**Date:** 2025-12-23
**Image:** secure-dashboard:v1.1
**Scanner:** Trivy (Aqua Security)

## 1. Executive Summary
This week focused on securing a Dockerized Flask application. We established a private registry, implemented version tagging, and integrated vulnerability scanning into the workflow.

## 2. Vulnerability Scan Results

### Initial Scan (v1.0)
* **Base Image:** python:3.9-slim (Debian 13.1)
* **Status:** Failed
* **Application Issues:** 2 Medium vulnerabilities found in `pip` (v23.0.1).
* **OS Issues:** 61 Low/Medium vulnerabilities in Debian system libraries.

### Remediation Actions Taken
1.  **OS Patching:** Updated `Dockerfile` to run `apt-get upgrade -y` during the build process.
2.  **Dependency Patching:** Added explicit command `pip install --upgrade pip` to ensure the latest secure version is used before installing requirements.
3.  **Rebuild:** Rebuilt image as `secure-dashboard:v1.1`.

### Final Scan (v1.1)
* **Status:** Passed (Application Level)
* **Total Vulnerabilities:** 61
* **Python/Pip Issues:** **0 (Fixed)** - The critical application-level vulnerabilities have been resolved.
* **OS Issues:** 61 - Remaining issues are Low/Medium severity system libraries related to the base image (Debian 13.2) which currently have no upstream fixes available.

## 3. Conclusion
The application dependencies are now secure. The remaining OS vulnerabilities are low risk and will be monitored for future updates from the Debian maintainers.
