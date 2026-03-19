export type RegisterParams = { email: string; password: string };

export const register = async ({
  email,
  password,
}: RegisterParams): Promise<string> => {
  const res = await fetch("/api/register", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ user: { email, password } }),
  });

  const body = await res.json().catch(() => ({}));

  if (!res.ok) {
    throw new Error("Register failed");
  }

  const token = body?.data?.token;

  if (!token) throw new Error("No token returned from server");

  return token;
};
