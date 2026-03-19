import { BrowserRouter, Routes, Route } from "react-router-dom";
import { JobList } from "./pages/JobList";
import { JobDetail } from "./pages/JobDetail";
import { CreateJob } from "./pages/CreateJob";
import { SignIn } from "./pages/SignIn";
import { SignUp } from "./pages/SignUp";
import { SignOut } from "./pages/SignOut";
import { Apply } from "./pages/Apply";

import "./index.css";

export const App = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/signin" element={<SignIn />} />
        <Route path="/signup" element={<SignUp />} />
        <Route path="/signout" element={<SignOut />} />

        <Route path="/" element={<JobList />} />
        <Route path="/jobs/:id" element={<JobDetail />} />
        <Route path="/jobs/:jobId/apply" element={<Apply />} />
        <Route path="/jobs/new" element={<CreateJob />} />
      </Routes>
    </BrowserRouter>
  );
};
