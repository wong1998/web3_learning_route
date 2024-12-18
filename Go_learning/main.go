package main

import (
	"context"
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {
	// 连接到本地 Hardhat 节点
	client, err := ethclient.Dial("http://127.0.0.1:8545")
	if err != nil {
		log.Fatalf("Failed to connect to the Ethereum client: %v", err)
	}

	// 获取最新区块高度
	blockNumber, err := client.BlockNumber(context.Background())
	if err != nil {
		log.Fatalf("Failed to get latest block number: %v", err)
	}
	fmt.Printf("Latest block number: %d\n", blockNumber)

	// 示例：获取某个账户的余额
	account := common.HexToAddress("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266") // 替换为实际地址
	balance, err := client.BalanceAt(context.Background(), account, nil)
	if err != nil {
		log.Fatalf("Failed to get balance: %v", err)
	}
	fmt.Printf("Balance of %s: %s\n", account.Hex(), balance.String())

	// 关闭客户端连接
	defer client.Close()
}
