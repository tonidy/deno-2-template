import { assertEquals } from "@std/assert";

Deno.test("GET / returns Hello, World!", async () => {
  const controller = new AbortController();
  const { signal } = controller;

  const HOST = "127.0.0.1";
  const PORT = 8000;

  // Removed async since no await is used inside
  const _erver = Deno.serve({ hostname: HOST, port: PORT, signal }, (req) => {
    const url = new URL(req.url);
    if (url.pathname === "/") {
      return new Response("Hello, World!", { status: 200 });
    }
    return new Response("Not Found", { status: 404 });
  });

  // Perform the request
  const response = await fetch(`http://${HOST}:${PORT}/`);
  const text = await response.text();

  // Assert the response
  assertEquals(response.status, 200);
  assertEquals(text, "Hello, World!");

  // Shut down the server
  controller.abort();
});
