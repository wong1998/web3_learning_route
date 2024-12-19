# WEB3学习之路

**目录知识结构**

**1、Go语言学习：基础语法->常用第三方库（包括Geth）**

**2、hardhat+solidity：编写Solidity合约及调试，部署开发区块链网络**

**3、React+Next：学习前端框架，实现DAPP的前端**

**4、Solana+Rust**



## Go语言学习

项目初始化：

`go mod init github.com/wong1998/web3_learning_route/Go_learning`

设置临时代理：

`$env:GOPROXY="https://goproxy.cn,direct"`

安装依赖：

`go get github.com/ethereum/go-ethereum`

安装gopls(支持编辑器代码跳转)：

`go install golang.org/x/tools/gopls@latest`

## hardhat+solidity

安装hardhat:

`npm install --save-dev hardhat`

初始化 Hardhat:

`npx hardhat`

启动本地开发网络:

`npx hardhat node`

编译合约:

`npx hardhat compile`

运行测试文件夹的脚本:

`npx hardhat test`

部署合约到本地网络:

`npx hardhat run --network hardhat  scripts/deploy.js`

## React+Next



## Solana+Rust



## 其他

Git使用方法

```
添加所有更改：

git add .

提交更改

git commit -m ""

推送更改

git push
```

