## gRPC CRUD example in Ruby

This project is an example of CRUD using gRPC communication in Ruby

### Setup

First, generate protobuf files with command bellow:

```bash
make
```
It's generate files on `pbs` directory, please DO NOT EDIT it.

### How to run project

In the terminal start server:

```bash
irb -r ./src/server/server.rb
```
Inside IRB console:

```ruby
Server.new.start
```
It's show `Starting GRPC Server on PORT: 50051` where port is 50051 by default

And starts the client

```bash
irb -r ./src/client.rb
```
Inside IRB console:

```ruby
client = Client.new
```
It will connected on server

### Execute CRUD

For example, execute follow functions to manipulate memory from client

For create resource

```ruby
client.create
```

For get a resource with id

```ruby
client.get 1
```
For get a list of resources

```ruby
client.list
```
For delete a resource

```ruby
client.delete 1
```
