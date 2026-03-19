export type LoginParams = { email: string; password: string };

export const login = async ({
  email,
  password,
}: LoginParams): Promise<string> => {
  const res = await fetch("/api/login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ user: { email, password } }),
  });

  const body = await res.json().catch(() => ({}));

  if (!res.ok) {
    throw new Error("Sign in failed");
  }

  const token = body?.data?.token;

  if (!token) throw new Error("No token returned from server");

  return token;
};
