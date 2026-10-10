# Shell Antivirus (OS Lab 2)

Shell scripts that watch a folder, move flagged files to a quarantine folder, and let you restore or delete them.

## 1. Overview

```
9772-lab2/
├── antivirus.sh          # scanner, loop version (runs forever, sleeps between scans)
├── antivirus-cron.sh     # scanner, one scan per run (used with cron)
├── restore.sh            # menu to restore or delete quarantined files
├── Makefile              # shortcuts: setup, run, cron, uncron, restore, clean
├── dir/                  # watched folder
├── malicious_dir/        # quarantine folder
├── whitelist/            # copies of restored files (skipped by the scanner)
├── directory-info.last   # snapshot of dir from the previous scan
├── directory-info.new    # snapshot of dir from the current scan
└── antivirus.log         # output of the cron job
```

## 2. Prerequisites (Ubuntu)

```bash
sudo apt update
sudo apt install -y make cron bash coreutils diffutils grep
sudo systemctl enable --now cron
```

## 3. Running

Run from inside the project folder. First, once:

```bash
make setup
```

### Run the antivirus: choose ONE of the two options

Use one option, not both, so two scanners don't watch the same folder.

**Option 1: `antivirus.sh` (loop, runs in the terminal)**
```bash
./antivirus.sh dir malicious_dir 5
```
Scans every 5 seconds. Stop it with `Ctrl+C`.

**Option 2: cron (`antivirus-cron.sh`, runs in the background)**
```bash
make cron       # scans every minute at second 23
make uncron     # stops it
```
To test a single scan by hand: `make run`.

### Run the restore tool

```bash
make restore
```
Type the file number, then choose: `1` restore, `2` delete permanently, `3` go back.

## 4. Flagged extensions and keywords

Both lists are in `antivirus.sh` and `antivirus-cron.sh`, inside the `for file` loop:

- **Extensions:** the `case` pattern `*.exe|*.bat|*.vbs|*.scr|*.ps1`
- **Keywords:** the `grep -E "virus|trojan|malware|worm|ransomware"` line
