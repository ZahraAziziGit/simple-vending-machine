
# Simple Vending Machine

This repository contains the implementation of a simple vending machine written in Verilog. The vending machine is designed to dispense items based on user input, manage inventory, and handle transactions. The simulation and testing of the design can be done using Icarus Verilog ([iverilog](https://bleyer.org/icarus/)). The wave simulation can be done by [gtkwave](https://gtkwave.sourceforge.net/).
This is a _digital logic design_ project, for Spring 2024. 

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Item Selection:** Allows users to select items from a predefined list.
- **Inventory Management:** Tracks the quantity of items in stock.
- **Transaction Handling:** Manages user inputs for selecting items and handling payments.
- **Error Handling:** Provides feedback for out-of-stock items or invalid inputs.
_you can read more details [here](https://github.com/ZahraAziziGit/simple-vending-machine/blob/main/Report%20(en).pdf)_.

## Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/ZahraAziziGit/simple-vending-machine.git
    ```
2. **Navigate to the project directory:**
    ```sh
    cd simple-vending-machine
    ```
3. **Install Icarus Verilog:**
    - For Ubuntu:
        ```sh
        sudo apt-get install iverilog
        ```
    - For macOS:
        ```sh
        brew install icarus-verilog
        ```
	- For windows: [link](https://bleyer.org/icarus/)
4. **Install GTKWave:**

	-   For Ubuntu:
		```sh
		sudo apt-get install gtkwave
		```		
	-  For macOS:
		```sh
		brew install gtkwave
		```
	- For windows: [link](https://gtkwave.sourceforge.net/)

## Usage

1. **Compile the Verilog files:**
    ```sh
    iverilog vending_machine_tb.v -o vending_machine_wave
    ```
2. **Run the simulation:**
    ```sh
    vvp vending_machine_wave
    ```
3. **Follow the simulation output to observe the vending machine's behavior.**

	```sh
	gtkwave test_vm.vcd
	```
  ![terminal](https://github.com/user-attachments/assets/143ccf32-5d11-4a00-a646-e3fed224a6ae)
  ![wave_complete](https://github.com/user-attachments/assets/4e7aa294-a642-4eea-a21a-81785d7141b9)

  

## Project Structure


```plaintext
simple-vending-machine/
├── LICENSE.txt
├── README.md
├── Report (en).pdf
├── test_vm.vcd
├── vending_machine.v
├── vending_machine_tb.v
└── vending_machine_wave

```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. **Fork the repository.**
2. **Create a new branch:**
    ```sh
    git checkout -b <feature-name>
    ```
3. **Make your changes and commit them:**
    ```sh
    git commit -m 'feat: add some feature'
    ```
4. **Push to the branch:**
    ```sh
    git push origin <feature-name>
    ```
5. **Open a pull request.**

## License
This project is licensed under the [MIT](https://github.com/ZahraAziziGit/simple-vending-machine?tab=MIT-1-ov-file#) License.

##

Thank you for checking out the Simple Vending Machine project! If you have any questions or feedback, feel free to reach out.

[Telegram](https://t.me/zahraAziziT)
E-mail: azizi.zahra.tehran@gmail.com
