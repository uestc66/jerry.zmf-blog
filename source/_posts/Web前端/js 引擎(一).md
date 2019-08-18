```
title: js 引擎
date: 2019-08-18 21:33:24
tags: Web前端
categories: Web前端
```





在 Facebook 发布 Hermes 引擎之前，Fabrice Bellard 以及 C 语言专家 Charlie Gordon 公开发布了 QuickJS。



[Facebook发布全新JS引擎！专注提高React Native应用的性能](https://mp.weixin.qq.com/s/0KxLQjI0jWxSt7sLqkS6Hw)



> 为了提高 Facebook 应用的性能，我们的团队不断改进自己的 JavaScript 代码和平台。在分析性能数据时，我们发现 JavaScript 引擎本身是影响启动性能和应用包体积的重要因素。有了这些数据，我们意识到必须在比 PC 端限制更多的移动环境中优化 JavaScript 性能。尝试了各种方案后，我们构建了一个新的 JavaScript 引擎：Hermes。它旨在提高应用性能，专注于 React Native 应用，并且在市面上那些内存较少、存储速度较慢且计算能力低下的移动设备上都有良好的表现。
>
> 主要特点：
>
> - 字节码预编译
> - 无 JIT
> - 垃圾回收策略



[轻量可嵌入的QuickJS引擎重磅开源，它会是下一个V8吗？](https://mp.weixin.qq.com/s/aUpxwQ6C4FZpnRZ151oFBA)

一路开挂的作者 Fabrice Bellard 是一位法国著名的计算机程序员，因 FFmpeg、QEMU 等项目而闻名业内。他也是最快圆周率算法贝拉公式、TCCBOOT 和 TCC 等项目的作者。

> QuickJS 支持 ES2019 规范，包括模块，异步生成器和代理，主要特点：

> - 小巧且易于嵌入：只需几个 C 文件，无外部依赖，x86 下一个简单的 hello world 示例程序仅 190 KB 的大小。
> - 具有极低启动时间的快速解释器：在台式 PC 的单核上，在大约 100 秒内运行 ECMAScript 测试套件56000 次测试。运行时实例的完整生命周期在不到 300 微秒的时间内完成。
> - 支持 ES2019 ，包括模块、异步生成器和完整的 Annex B 支持（传统的 Web 兼容性）。
> - 100％的通过了 ECMAScript 测试用例。
> - 可以将 Javascript 源编译为没有外部依赖的可执行文件。
> - 使用引用计数（以减少内存使用并具有确定性行为）的垃圾收集与循环删除。
> - 数学扩展：BigInt，BigFloat，运算符重载，bigint 模式，数学模式。
> - 在 Javascript 中实现的具有上下文着色的命令行解释器。
> - 带有 C 库包装库构建的内置标准库。



##### PS: 前端性能优化终于走到了 js 引擎的层面。为了更好地地了解引擎技术，我们先来温故一下 js 基础机制：



##### [开发做了这么多年，你真的了解JS工作机制吗？](https://mp.weixin.qq.com/s/1dFm8BoznK4eXA7pihsqLg)

- JIT

> 将 JS 视为一种解释性语言是不对的。以前很多年 JS 的确是解释性的，但最近出现了一些变化，这种假设也随之过时了。许多流行的 JS 引擎为了使 JS 执行更快，引入了一种称为 Just-In-Time 编译的功能。简而言之，这意味着 JS 代码会在执行期间直接编译成机器码（至少 V8 是这样做的），不再有解释这一步。这个流程耗时稍长，但**输出的结果性能更强**。为了在有限的时间内完成工作，V8 实际上有**两个编译器**（不算与 WebAssembly 相关的内容）。其中一个是通用的，能够非常快地编译任何 JS 代码，但只输出性能一般的结果；而另一个编译速度有点慢，是用来编译常用代码的，其输出结果性能极高。当然，因为 JS 有动态类型的特性，这些编译器也不好做。所以类型不变的情况下第二个编译器的效果最好，能让你的代码运行起来快得多。



- 堆和栈

> 在 JS 代码的执行过程中会分配两个内存区域——调用栈和 堆。第一个性能非常高，因此用于连续执行所提供的函数。每个函数调用在调用栈中创建一个所谓的“框架”，其中包含其局部变量的副本和 this。你可以通过 Chrome 调试器查看它。就像在其他与堆栈类似的数据结构中一样，调用栈的帧被推送或弹出堆栈，具体取决于正在执行或终止的新函数。你可能见过调用栈上限溢出错误，通常是由于某种形式的无限循环导致的。
>
> 谈到堆，就像现实生活中一样，JS 堆是存储本地范围之外对象的地方。它比调用栈慢得多。这就是为什么访问本地变量时速度可能会快很多。堆也是存放未被访问或使用的对象的地方，这种对象就是垃圾。有垃圾就要有垃圾回收器。需要时 JS 运行时的垃圾回收器就会激活，清理堆并释放内存。



##### [前端内存相关探索](https://www.atatech.org/articles/138732)



- 堆和栈

> 在前端中，被存储在栈内的数据包括小数值型，string ，boolean 和复杂类型的地址索引。所谓小数值数据(small number), 即长度短于 32 位存储空间的 number 型数据。一些复杂的数据类型，诸如 Array，Object 等，是被存在堆中的。



- 共享内存

> 当程序变的过于复杂时，我们希望通过 webworker 来开启新的独立线程，完成独立计算。
>
> 开启新的线程伴随而来的问题就是通讯问题。webworker 的 postMessage 可以帮助我们完成通信，但是这种通信机制是将数据从一部分内存空间复制到主线程的内存下。这个赋值过程就会造成性能的消耗。
>
> 而共享内存，顾名思义，可以让我们在不同的线程间，共享一块内存，这些现成都可以对内存进行操作，也可以读取这块内存。省去了赋值数据的过程，不言而喻，整个性能会有较大幅度的提升。



使用原始的 postMessage 方法进行数据传输使用，每一个消息内的数据在不同的线程中，都是**被克隆一份以后再传输的**。**数据量越大，数据传输速度越慢**。 sharedBufferArray 的消息传递通过共享内存传递的数据，**在 worker 中改变了数据以后，主线程的原始数据也被改变了**。



main.js

```
var worker = new Worker('./sharedArrayBufferWorker.js');

worker.onmessage = function(e){
    // 传回到主线程已经被计算过的数据
    console.log("e.data","   -- ", e.data );
    // SharedArrayBuffer(3) {}

    // 和传统的 postMessage 方式对比，发现主线程的原始数据发生了改变
    console.log("int8Array-outer","   -- ", int8Array );
    // Int8Array(3) [2, 3, 4]
};

var sharedArrayBuffer = new SharedArrayBuffer(3);
var int8Array = new Int8Array(sharedArrayBuffer);

int8Array[0] = 1;
int8Array[1] = 2;
int8Array[2] = 3;

worker.postMessage(sharedArrayBuffer);
```



worker.js

```
onmessage = function(e){
    var arrayData = increaseData(e.data);
    postMessage(arrayData);
};

function increaseData(arrayData){
    var int8Array = new Int8Array(arrayData);
    for(let i = 0; i < int8Array.length; i++){
        int8Array[i] += 1;
    }

    return arrayData;
}
```



##### [前端 Web Workers 到底是什么？](https://mp.weixin.qq.com/s/i1xBLUtVRPhWnl_1EuJVkA)

> worker线程的使用有一些注意点
>
> - 同源限制 worker线程执行的脚本文件必须和主线程的脚本文件同源，这是当然的了，总不能允许worker线程到别人电脑上到处读文件吧
> - 文件限制 为了安全，worker线程无法读取本地文件，它所加载的脚本必须来自网络，且需要与主线程的脚本同源
> - DOM操作限制 worker线程在与主线程的window不同的另一个全局上下文中运行，其中无法读取主线程所在网页的DOM对象，也不能获取 `document`、 `window`等对象，但是可以获取 `navigator`、 `location(只读)`、`XMLHttpRequest`、 `setTimeout族`等浏览器API。
> - 通信限制 worker线程与主线程不在同一个上下文，不能直接通信，需要通过 `postMessage`方法来通信。
> - 脚本限制 worker线程不能执行 `alert`、 `confirm`，但可以使用 `XMLHttpRequest` 对象发出ajax请求。



[漫谈前端性能 突破 React 应用瓶颈](https://zhuanlan.zhihu.com/p/42032897)

React 结合 Web worker ? 尝试在 Web worker 中运行 React Virtual DOM 的相关计算，即将 React core 部分移入 Web worker 线程中 ? 还真有人提出类似想法：[3092 issue](https://github.com/facebook/react/issues/3092)，但是提案被拒绝了，react 选择的是 [React Fiber](https://www.infoq.cn/article/what-the-new-engine-of-react/)。



但是这个并不妨碍 Web worker 成为 “民间” 的 **react 性能解药**：

##### [React Redux 中间件思想遇见 Web Worker 的灵感（附demo）](https://zhuanlan.zhihu.com/p/28525821)



另外举个例子对比: http://web-perf.github.io/react-worker-dom/