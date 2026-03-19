import { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Button } from "welcome-ui/Button";
import { Text } from "welcome-ui/Text";
import { Card } from "welcome-ui/Card";
import { Tag } from "welcome-ui/Tag";
import { Loader } from "welcome-ui/Loader";
import Cookies from "js-cookie";
import { logout } from "../api/logout";

interface Job {
  id: string;
  title: string;
  description: string;
  contract_type: string;
  office: string;
  status: string;
}

export const JobList = () => {
  const [jobs, setJobs] = useState<Job[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [hasBearerToken, setHasBearerToken] = useState<boolean>(false);
  const [user, setUser] = useState<{ id: string; email: string } | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    fetch("/api/jobs")
      .then((res) => res.json())
      .then((response: { data: Job[] }) => {
        setJobs(response.data);
        setLoading(false);
      })
      .catch((err) => {
        setError(err.message);
        setLoading(false);
      });
  }, []);

  useEffect(() => {
    const csrfToken = Cookies.get("technical-test-csrf-token");
    const bearerToken = Cookies.get("user-token");
    setHasBearerToken(Boolean(bearerToken));

    if (bearerToken) {
      (async () => {
        try {
          const res = await fetch("/api/me", {
            credentials: "include",
            headers: {
              Accept: "application/json",
              Authorization: `Bearer ${bearerToken}`,
              ...(csrfToken ? { "x-csrf-token": csrfToken } : {}),
            },
          });

          if (res.ok) {
            const body = await res.json().catch(() => ({}));
            setUser(body?.data ?? null);
          } else {
            setUser(null);
          }
        } catch (e) {
          setUser(null);
        }
      })();
    }
  }, []);

  if (loading) return <Text>Loading...</Text>;
  if (error) return <Text color="red">Error: {error}</Text>;

  return (
    <div className="p-xl max-w-1200 my-0 mx-auto">
      <div className="flex items-center justify-between mb-lg">
        <Text variant="heading-xl">Job Listings</Text>

        {hasBearerToken ? (
          <div className="flex items-center gap-sm">
            {user ? (
              <>
                <Text variant="body-sm">{user.email}</Text>
                <Button
                  size="sm"
                  variant="tertiary"
                  onClick={async () => {
                    try {
                      await logout();
                    } catch (e) {}
                    setUser(null);
                    setHasBearerToken(false);
                    navigate("/signin");
                  }}
                >
                  Logout
                </Button>
              </>
            ) : (
              <Loader size="sm" />
            )}
          </div>
        ) : (
          <div className="flex gap-sm">
            <Button as={Link} to="/signup" size="sm">
              Sign up
            </Button>
            <Button as={Link} to="/signin" size="sm" variant="tertiary">
              Sign in
            </Button>
          </div>
        )}
      </div>

      <div className="flex flex-col gap-md">
        {user && (
          <div className="flex items-center justify-end gap-sm">
            <Button as={Link} to="/jobs/new" size="sm">
              Create a new job
            </Button>
          </div>
        )}
        {jobs.map((job) => (
          <Card key={job.id} size="sm">
            <Card.Body>
              <div className="flex items-start justify-between gap-md">
                <div className="flex-1 min-w-0">
                  <Link
                    to={`/jobs/${job.id}`}
                    className="no-underline hover:underline"
                  >
                    <Text variant="heading-md">{job.title}</Text>
                  </Link>
                  <Text variant="body-sm" className="mt-xs" lines={2}>
                    {job.description}
                  </Text>
                  <div className="flex flex-wrap gap-xs mt-sm">
                    <Tag size="md" variant={"blue"}>
                      {job.contract_type}
                    </Tag>
                    <Tag size="md" variant="light-blue">
                      {job.office}
                    </Tag>
                    <Tag size="md" variant={"green"}>
                      {job.status}
                    </Tag>
                  </div>
                </div>
                <Button as={Link} to={`/jobs/${job.id}/apply`} size="sm">
                  Apply
                </Button>
              </div>
            </Card.Body>
          </Card>
        ))}
      </div>
    </div>
  );
};
