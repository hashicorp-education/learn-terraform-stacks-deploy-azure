output "hello_urls" {
  type = list(string)
  description = "URLs to invoke functions"
  value = [ for x in component.function: x.invoke_url ]
}
