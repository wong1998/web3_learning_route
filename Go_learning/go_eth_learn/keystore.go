package main

import (
    "fmt"
    "io/ioutil"
    "log"
    "os"

    "github.com/ethereum/go-ethereum/accounts/keystore"
)

func createKs() {
    ks := keystore.NewKeyStore("./tmp", keystore.StandardScryptN, keystore.StandardScryptP)
    password := "secret"
    account, err := ks.NewAccount(password)
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println(account.Address.Hex()) // 0x20F8D42FB0F667F2E53930fed426f225752453b3
}

func importKs() {
    file := "./tmp/UTC--2024-12-19T14-45-59.156942100Z--140a4e4abbcb551f619e4451590c920d8a513947"
    ks := keystore.NewKeyStore("./tmp", keystore.StandardScryptN, keystore.StandardScryptP)
    jsonBytes, err := ioutil.ReadFile(file)
    if err != nil {
        log.Fatal(err)
    }

    password := "secret"
    account, err := ks.Import(jsonBytes, password, password)
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println(account.Address.Hex()) // 0x20F8D42FB0F667F2E53930fed426f225752453b3

    if err := os.Remove(file); err != nil {
        log.Fatal(err)
    }
}

func main() {
    // createKs()
    importKs()
}