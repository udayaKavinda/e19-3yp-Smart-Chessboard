---
layout: home
permalink: index.html

# Please update this with your repository name and project title
repository-name: e19-3yp-Smart-Keyboard
title: Smart Keyboard
---

[comment]: # "This is the standard layout for the project, but you can clean this and use your own template"

# Smart Keyboard

---

## Team
-  E/19/096, E.M.C.Y.B.Ekanayake, [email](e19096@eng.pdn.ac.lk)
-  E/19/100, E.P.S.G.Ellewela, [email](e19100@eng.pdn.ac.lk)
-  E/19/155, B.R.U.K.Jayarathne, [email](e19155@eng.pdn.ac.lk)
-  E/19/253, N.K.B.I.U Narasinghe, [email](e19253@eng.pdn.ac.lk)
-  E/19/306, M.M.P.N.Rajakaruna, [email](e19306@eng.pdn.ac.lk)

<!-- Image (photo/drawing of the final hardware) should be here -->

<!-- This is a sample image, to show how to add images to your page. To learn more options, please refer [this](https://projects.ce.pdn.ac.lk/docs/faq/how-to-add-an-image/) -->

<!-- ![Sample Image](./images/sample.png) -->

#### Table of Contents
1. [Introduction](#introduction)
2. [Solution Architecture](#solution-architecture )
3. [Hardware & Software Designs](#hardware-and-software-designs)
4. [Testing](#testing)
5. [Detailed budget](#detailed-budget)
6. [Conclusion](#conclusion)
7. [Links](#links)

## Introduction

welcome to a presentation that marks the dawn of a new era in the world of chess
Our project revolves around addressing key challenges faced by chess enthusiasts, both visually impaired and sighted.


## Solution Architecture

<h2>High Level Architecture</h2>

![highlevel_archi](https://github.com/cepdnaclk/e19-3yp-Smart-Keyboard/assets/115540884/fc9bb615-1ec0-4e7b-aaeb-0869a08dcda3)

<h2>Data Flow</h2>

![DataFlow](https://github.com/cepdnaclk/e19-3yp-Smart-Keyboard/assets/115540884/9a6249d8-d351-4d92-9b7f-d8eb3b9cede5)

<h2>Control Flow</h2>

<h3>Choose a way to play</h3>

![control-flow-1](https://github.com/cepdnaclk/e19-3yp-Smart-Chessboard/assets/115540884/5e41f244-d92a-4b7a-8587-f401529a23f4)

<h3>Playing a local game</h3>

![Copy of sMART Chess (1)](https://github.com/cepdnaclk/e19-3yp-Smart-Chessboard/assets/115540884/62fac991-d913-4d67-a959-0b89b6a23907)

<h3>Playing with a computer opponent</h3>

![controlflow-3](https://github.com/cepdnaclk/e19-3yp-Smart-Chessboard/assets/115540884/6291e740-944f-4238-8daf-a04e5eea6022)

<h3>Playing with an opponent through aws backend or lichers</h3>

![controlflow-4](https://github.com/cepdnaclk/e19-3yp-Smart-Chessboard/assets/115540884/6e6269cc-1a1c-4b2d-b851-17a1eed633ff)

## Hardware and Software Designs


<h3>Circuit Diagram</h3>

![WIRE MAP (1)](https://github.com/cepdnaclk/e19-3yp-Smart-Chessboard/assets/115540884/9711a99d-9e6a-41d5-8539-abcba2f44955)

<h3>User Interface</h3>

![Sign Up, Login page (Community)](https://github.com/cepdnaclk/e19-3yp-Smart-Chessboard/assets/115540884/f38cc830-466d-4e25-904a-bf5c3e2fb898)


## Testing

Testing done on hardware and software, detailed + summarized results

## Detailed budget

All items and costs

| Item                                 | Quantity   | Unit Cost   | Total     |
| -------------------------------------|:----------:|:-----------:|----------:|
| ESP32 Board                          |  1         | 2950 LKR    | 2950 LKR  |
| Nema17 Stepper Motors                |  2         | 2400 LKR    | 4800 LKR  |
| Stepper Motor Drivers (A4988)        |  2         |  400 LKR    |  800 LKR  |
| Electro Magnet (5kg holding force)   |  1         | 2100 LKR    | 2100 LKR  |
| 12V Power Supply Unit                |  1         | 1700 LKR    | 1700 LKR  |
| Buck Converters                      |  2         | 1050 LKR    | 2100 LKR  |
| Multiplexers (SparkFun-CD74HC4067)   |  4         |  550 LKR    | 2200 LKR  |
| Steel Rods                           |  2         | 2050 LKR    | 4100 LKR  |
| Magnets                              | 32         |   18 LKR    |  600 LKR  |
| 8 pin Ribbon Cables                  |  8         |   56 LKR    |  450 LKR  |
| GT2 Timing Belts                     |  3 (metres)|  500 LKR    | 1500 LKR  |
| GT2 Pulleys                          |  2         |  600 LKR    | 1200 LKR  |
| GT2 Toothless Pulleys                |  4         | 1100 LKR    | 4400 LKR  |
| Arcadde Buttons                      |  2         |  200 LKR    |  400 LKR  |
| Micro Limit Switcher Roller          |  4         |  470 LKR    | 1880 LKR  |
| A3144 Hall Effect Sensors            | 70         |   47 LKR    | 3300 LKR  |
| TIP120 Transistor                    |  1         |   50 LKR    |   50 LKR  |
| Foamboards                           |  1         | 1600 LKR    | 1600 LKR  |
| Chess pieces & Board Sticker         |  1         | 2000 LKR    | 2000 LKR  |
| TOTAL                                |            |             | 37530 LKR |

## Conclusion

What was achieved, future developments, commercialization plans

## Links

- [Project Repository](https://github.com/cepdnaclk/{{ page.repository-name }}){:target="_blank"}
- [Project Page](https://cepdnaclk.github.io/{{ page.repository-name}}){:target="_blank"}
- [Department of Computer Engineering](http://www.ce.pdn.ac.lk/)
- [University of Peradeniya](https://eng.pdn.ac.lk/)

[//]: # (Please refer this to learn more about Markdown syntax)
[//]: # (https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
