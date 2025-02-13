
# EduEvents: Smart Educational Event System  

## Project Description  

EduEvents is a next-generation Smart Educational Event System (SEES) designed to overcome the limitations of traditional event-based educational platforms. Our system aims to provide a scalable, efficient, and interactive environment where educators, attendees, and stakeholders can seamlessly engage, collaborate, and share knowledge. By integrating automation, networking, and data-driven insights, EduEvents enhances event management, attendee experience, and event optimization.  

## Key Features  

### 1. Networking & Engagement  
- **Direct Messaging** – Attendees can contact speakers and organizers.  
- **Q&A Sections** – Address common attendee questions before events.  
- **Discussion Forums** – Dedicated spaces for post-event discussions.  

### 2. Automated Event Management  
- **Self-Booking System** – Organizers and speakers can access and book venue schedules.  
- **Automated Confirmations** – Instant confirmation emails for event approvals.  
- **Centralized Dashboards** – Real-time updates on schedules, speakers, and venue changes.  

### 3. Advanced Analytics for Executive Personnel  
- **Attendance & Engagement Tracking** – Monitor participation and interactions.  
- **Speaker Performance Insights** – Data-driven feedback for session improvement.  
- **Incentivized Feedback Collection** – Attendees earn free memberships for providing event feedback.  

## Team Members
- Idris Drouiche
- Faisal Quraishi
- Ahmad Saadawi
- Vladimir Shterenkiker
- Gabriel Shufelt

---

# Environment Setup

## Windows Installation

### Ruby Installation
1. Install the latest version of Ruby with the DevKit from [here](https://rubyinstaller.org/downloads/).
2. After installation is complete, make sure to check "Launch MSYS2"
3. Once the terminal opens, install all components by pressing `Enter`.
4. Once everything has been installed, press enter to close the MSYS2 terminal.

### PostgreSQL Installation
5. Download the lastest version of the PostgreSQL Installer from [here](https://www.postgresql.org/download/windows/).
6. Once downloaded, check your installation by running `psql --version` in your terminal. 

### Install Rails Dependencies
7. Download and Install Node.js from [NodeJS' prebuilt's installers](https://nodejs.org/en/download/prebuilt-installer/current).
8. In a new terminal, make sure npm was installed correctly:

```
$ npm --version
10.8.2
```

9. Next, in new terminal install yarn:

```
npm install --global yarn
```

10. Make sure it was installed by opening a new terminal and typing:

```
$ yarn --version
1.22.22
```

### Rails Installation
11. Next, in a new terminal install rails:

```
gem install rails
```

12. Make sure it was installed correctly by typing:

```
$ rails --version
Rails 7.1.4
```
---

## MacOS Installation

### **1. Install Homebrew**  
If you don’t have Homebrew installed, run:  

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Verify installation:
```
brew -v
Homebrew 4.4.20
```
### **2. Install PostgreSQL**
Install PostgreSQL using Homebrew:

```sh
brew install postgresql
```

Start PostgreSQL
```sh
brew services start postgresql
```

Verify Installation
```
psql --version
psql (PostgreSQL) 14.15 (Homebrew)
```

### **3. Install RVM (Ruby Version Manager)**
Install RVM:
```
\curl -sSL https://get.rvm.io | bash -s stable
```

Load RVM
```
source ~/.rvm/scripts/rvm
```

Add this line to your ~/.zshrc:
```
echo 'source ~/.rvm/scripts/rvm' >> ~/.zshrc
source ~/.zshrc
```

### **4. Install Ruby**
Install ruby-3.4.1:
```
rvm install 3.4.1
rvm use 3.4.1 --default
```

### **5. Install Rails**
```
sudo gem install rails
```

### Troubleshooting

If you get the following error when trying to install ruby with `rvm install "ruby-3.4.1"`:
```
Error running '__rvm_make -j16',
There has been an error while running make. Halting the installation.
```
Try running:
```
brew install openssl@1.1
rvm install 3.4.1 --with-openssl-dir=`brew --prefix openssl@1.1` --with-opt-dir=`brew --prefix openssl@1.1`
```

### Getting Started

- If you are using VSCode, navigate to File > Open Folder. Select the folder where you just cloned this repository.
- Whenever you pull new changes from the repository, make sure to run `bundle install`. This will install any missing gems needed to run the application.
- In order to always have the most recent version of the database, make sure to run:

```
db:reset    # drops database, re-creates it, and runs pending migrations
db:seed     # populates the database with data defined in db/seeds.rb
```

- Can also run the following if the previous prompts did not work:

```
rails db:drop:_unsafe
rails db:create
rails db:migrate
rails db:seed
```

- Finally, launch your server by running `rails s`
- If everything was installed correctly, you will be able to visit our app at [http://localhost:3000/](http://localhost:3000/)