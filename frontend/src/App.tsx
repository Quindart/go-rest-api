import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import axios from "axios";
import { useCallback, useEffect, useState } from "react";

type User = {
  id: string;
  name: string;
  email: string;
  age: number;
};

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL ?? "http://localhost:8080";

function App() {
  const [users, setUsers] = useState<User[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchUsers = useCallback(async () => {
    try {
      setIsLoading(true);
      setError(null);
      const response = await axios.get<User[]>(`${API_BASE_URL}/users`);
      setUsers(response.data);
    } catch (err) {
      setError("Không thể tải danh sách users từ backend.");
      setUsers([]);
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    void fetchUsers();
  }, [fetchUsers]);

  return (
    <main className="min-h-screen bg-background text-foreground">
      <div className="container py-16">
        <Card className="mx-auto max-w-2xl">
          <CardHeader>
            <CardTitle>Users từ Backend API</CardTitle>
            <CardDescription>
              Endpoint: {API_BASE_URL}/users
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center justify-between gap-4">
              <p className="text-sm text-muted-foreground">
                {isLoading ? "Đang tải dữ liệu..." : `Tìm thấy ${users.length} user(s).`}
              </p>
              <Button onClick={() => void fetchUsers()} disabled={isLoading}>
                {isLoading ? "Loading..." : "Tải lại"}
              </Button>
            </div>

            {error ? <p className="text-sm text-destructive">{error}</p> : null}

            <ul className="space-y-2">
              {users.map((user) => (
                <li key={user.id} className="rounded-md border p-3">
                  <p className="font-medium">{user.name}</p>
                  <p className="text-sm text-muted-foreground">{user.email}</p>
                  <p className="text-sm text-muted-foreground">Age: {user.age}</p>
                </li>
              ))}
            </ul>
          </CardContent>
        </Card>
      </div>
    </main>
  );
}

export default App;
