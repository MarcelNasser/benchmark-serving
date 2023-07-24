package main

import (
    "fmt"
    "os"
    "log"
    "github.com/redis/go-redis/v9"
    "context"
    "strconv"
    "net/http"
)


func main() {
    ctx := context.Background()
    db, err := strconv.ParseInt(os.Getenv("DB"), 10, 0)
    if err != nil {
		log.Printf("Bad db number '%s'", os.Getenv("DB"))
		panic(err)
	}
    connexion_string:=fmt.Sprintf("redis://%s:%s@redis:6379/%d",os.Getenv("USERNAME"),os.Getenv("PASSWORD"),db)
    opt, err := redis.ParseURL(connexion_string)
    if err != nil {
        log.Println(err)
        panic(err)
    }
    client := redis.NewClient(opt)
    err0 := client.Set(ctx, "Hello", "world", 0).Err()
    if err0 != nil {
        log.Println(err0)
    }
    //Get Handler
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        val, err := client.Get(ctx, "Hello").Result()
        if err != nil {
            fmt.Fprintf(w, fmt.Sprintf("Go server: Error: %s", err))
        } else {
            fmt.Fprintf(w, fmt.Sprintf("Go server: Hello, %s!",val))
        }
    })
    http.ListenAndServe(":8080", nil)
}
