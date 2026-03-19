import Cookies from "js-cookie";

export const logout = async (): Promise<void> => {
  const res = await fetch("/api/logout", { method: "DELETE" });

  if (!res.ok) {
    throw new Error("Sign out failed");
  }

  Cookies.remove("user-token");

  return;
};
