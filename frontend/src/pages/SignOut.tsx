import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { logout } from "../api/logout";

export const SignOut = () => {
  const navigate = useNavigate();

  useEffect(() => {
    const handleSignOut = async () => {
      try {
        await logout();
      } catch (e) {}
      navigate("/signin", { replace: true });
    };

    handleSignOut();
  }, [navigate]);

  return <div>Signing out...</div>;
};
