package main

import (
    "fmt"
    "os"
    "github.com/redis/go-redis/v9"
    "context"
    "net/http"
)


func main() {
    ctx := context.Background()
    connexion_string:=fmt.Sprintf("redis://%s:%s@localhost:6379/%s",os.Getenv("USER"),os.Getenv("PASSWORD"),os.Getenv("DB"))
    opt, err := redis.ParseURL(connexion_string)
    if err != nil {
        panic(err)
    }
    client := redis.NewClient(opt)
    err0 := client.Set(ctx, "Hello", "world", 0).Err()
    if err0 != nil {
        panic(err)
    }
    val, err := client.Get(ctx, "foo").Result()
    if err != nil {
        panic(err)
    }
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello, world!")
    })
    http.ListenAndServe(":8080", nil)
}
