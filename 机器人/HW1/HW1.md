# HW1
## 什么是被动行走

- Gravity and inertia alone generate the locomotion pattern. [McGeer, 1990]
- A completely unactuated and therefore uncontrolled robot can perform a stable walk. [Schwab, 2001]
- Passive Dynamic Walking robots are robots that show a perfectly stable gait when walking down a
gentle slope without any control or actuation. [Hobbelen, 2008]

&emsp;&emsp; 综上，被动行走可以被视为混合系统产生的一种物理现象，其中包括腿摆动动作的连续动态和离散的腿交换事件。被动行走是一种未经激励的惰性运动行为。
被动步行可以展示一个稳定的极限环，当状态保持稳定极限环，则步行系统是稳定的。

## 描述研究被动行走主要包括哪些内容

- Basin of Attraction [Schwab, 2001]
  - 定义：机器人状态空间中保证稳定的步行步态的一组初始条件；
  - 它的大小可以通过映射方法来分析。最重要的是分析其大小随上坡坡度增加的变化率 $\gamma$.
- Equations of Motion
  - 步幅函数： $v_{n + 1} = S(v_n)$
- Step-to-Step behavior
  - 故障模式：前倾摔倒或后倾摔倒；
  - 循环运动：$v_{n + k} = v_n$
  - Cell mapping method: 动态系统的连续状态空间被离散成有限数量的单元格。通过研究这些单元格之间的转移来分析系统的行为。

- Evaluation aspects: Energy efficiency, versatility and disturbance rejection.[Hobbelen, 2008]

## 什么是准被动行走
- Quasi-PDW means that a robot usually does PDW without any input torques, and the actuators of the robot are used just only when the walking begins or disturbances come in;
- Positively utilizing the passive dynamics of the system to enable underactuated legged robots to walk efficiently and stably on level ground.


&emsp;&emsp;综上，准被动行走是指除了开始阶段以及干扰时刻外，其余时刻均采用无输出的被动行走模式。

## 讨论一种或许可行的准被动行走
&emsp;&emsp;Asano Fumihiko教授和Tokuda Isao教授提出了一种凭借机械共振来实现的在水平路面的行走模式。步行系统由两个无框轮和一个振子以及一个连杆组成。这一系统的特点是，无框轮与连杆之间没有传统的力矩输入，然而振子却可以被控制进行周期性振荡。利用机械振荡来引起机器人行走的共振，从而通过对振子的控制来间接激励机器人的步态。
&emsp;&emsp;从李龙川博士Energy-Efficient Locomotion Generation and Theoretical Analysis of a Quasi-Passive Dynamic Walker文章中可以得到一种准被动行走机器人，与连接型无框轮类似，该机器人的转动关节处不施加任何力矩，在连杆上，振子可以进行前后振荡。在控制机器人时，由于冗余的输入所带来的能量会在与地面的碰撞中消耗掉，所以不施加传统的转矩，而是控制振子追踪正弦函数。一方面，振子的周期性振荡引起机器人的共振，为系统收敛于稳态提供可能。另一方面，由于迈步是由振子的间接激励所实现的，其间并没有给与机器人多余的能量。因此，我们凭借这一方法实现了水平路面上的准被动行走。
&emsp;&emsp;准被动行走要求尽可能利用系统的自然动力，因此稳定的共振系统是一个极好的选择。我认为除此之外，在理想条件下，一个依靠液压转子连接两个机械腿交替前进的方案也是可取的——即先在斜面上使得机器人获得一定的能量，再逐渐减小斜面角度至水平，接下来在机械腿接触平面的时刻，液压转子使得后方的腿交替至前方，进而形成行走动作。
