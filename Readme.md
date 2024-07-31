# Certifying IoT Data with Verifiable Credentials

This project allows issuing Verifiable Credentials on an IoT device supporting embedded Linux.

## 1. SSH Access to the Testbed

### Register on Fit IoT-Lab
First, register on the Fit IoT-Lab Testbed [here](https://www.iot-lab.info/). After registration, associate your SSH key with your account.

### Generate SSH Key
Generate an SSH key pair using the following command:

```bash
ssh-keygen -t rsa
```

When prompted to "Enter a file in which to save the key," press Enter to accept the default file location:

```
Enter a file in which to save the key (/home/you/.ssh/id_rsa): [Press Enter]
```

Follow the instructions on the site to complete the SSH setup: [Fit IoT-Lab SSH Access Guide](https://www.iot-lab.info/docs/getting-started/ssh-access/).

## 2. Building Your Application

To build your application, use Docker to virtualize the build environment.

### Install Docker
Install Docker by following the instructions on the [Docker website](https://www.docker.com/).

### Run the Docker Environment
To set up the Docker environment for building your application, run:

```bash
docker build -t rust-arm-compiler .
```

### Compile the Project
Navigate to the workspace and compile your project with the following commands:

```bash
cd /workspace
cargo build --target armv7-unknown-linux-gnueabihf
```

If everything is configured correctly, the project should compile for ARM using the compatible system version. The binary should be located in \`/target/armv7.../debug\`. To facilitate workflow, copy the binary outside \`/target\`, zip it with \`gzip\`, and then compress the file with \`tar\`.

## 3. Set Up the SSH Frontend

In your SSH frontend, navigate to the \`shared\` directory, which is shared with the submitted board:

```bash
cd shared
```

Clone the repository:

```bash
git clone https://github.com/Allevs01/VCIoT.git
```

Unzip the tar file and move it outside the repository (for semplicity, there is already the bin on the repo).

## 4. Test on IoT A8-M3

From the SSH frontend, submit the experiment with the following command:

```bash
iotlab-experiment submit -n first-exp -d 800 -l 1,archi=a8:at86rf231+site=Grenoble
```

Check the submitted node:

```bash
iotlab-experiment get -n
```

### Access the Board
Get access to the board:

```bash
ssh root@node-a8-10n(node number, obtained from the previous command)
```

### Install Rust
Once on the board, install Rust:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### Run the Binary
Copy the binary from \`shared\` to the root directory:

```bash
cp -r ~/shared/VCIoT/10claim ~/
```

Run the binary:

```bash
./10claim
```
