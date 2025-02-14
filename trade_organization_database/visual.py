import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import psycopg2
import csv

# Подключение к базе данных
def connect_db():
    return psycopg2.connect(
        dbname="alexfresh59",
        user="alexfresh59",
        password="492760",
        host="localhost"
    )

class DatabaseInterface:
    def __init__(self, root):
        self.root = root
        self.root.title("Database Manager")
        self.root.geometry("1920x1080")
        
        # Навигационная панель
        self.nav_frame = tk.Frame(self.root)
        self.nav_frame.pack(side=tk.TOP, fill=tk.X)

        self.table_buttons = {
            "Products": lambda: self.display_table("product"),
            "Сlient": lambda: self.display_table("client"),
            "Sales": lambda: self.display_table("sales"),
            "Provider": lambda: self.display_table("provider"),
            "Sales_composition": lambda: self.display_table("sales_composition"),
            "Сategoty": lambda: self.display_table("categoty")
        }
        for name, command in self.table_buttons.items():
            button = tk.Button(self.nav_frame, text=name, command=command, width=15)
            button.pack(side=tk.LEFT, padx=5, pady=5)
        
        # Фрейм для содержимого таблицы
        self.content_frame = tk.Frame(self.root)
        self.content_frame.pack(fill=tk.BOTH, expand=True)

        # Панель управления
        self.control_frame = tk.Frame(self.root)
        self.control_frame.pack(side=tk.BOTTOM, fill=tk.X)
        
        # Таблица отображения данных
        self.tree = None
        self.current_table = None

    def display_table(self, table_name):
        self.current_table = table_name
        for widget in self.content_frame.winfo_children():
            widget.destroy()

        conn = connect_db()
        cur = conn.cursor()

        # Получение данных
        cur.execute(f"SELECT * FROM trade_organization.{table_name} LIMIT 100")
        rows = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]

        # Создание таблицы
        self.tree = ttk.Treeview(self.content_frame, columns=column_names, show="headings")
        for col in column_names:
            self.tree.heading(col, text=col)
            self.tree.column(col, width=100)
        self.tree.pack(fill=tk.BOTH, expand=True)

        # Добавление данных в таблицу
        for row in rows:
            self.tree.insert("", tk.END, values=row)

        conn.close()

        # Управляющие кнопки
        self.setup_controls()

    def setup_controls(self):
        for widget in self.control_frame.winfo_children():
            widget.destroy()

        # Добавление записи
        add_button = tk.Button(self.control_frame, text="Add", command=self.add_record)
        add_button.pack(side=tk.LEFT, padx=5)

        # Удаление записи
        delete_button = tk.Button(self.control_frame, text="Delete", command=self.delete_record)
        delete_button.pack(side=tk.LEFT, padx=5)

        # Обновление записи
        update_button = tk.Button(self.control_frame, text="Update", command=self.update_record)
        update_button.pack(side=tk.LEFT, padx=5)

        # Поиск записи
        search_button = tk.Button(self.control_frame, text="Search", command=self.search_record)
        search_button.pack(side=tk.LEFT, padx=5)

        # Экспорт в CSV
        export_button = tk.Button(self.control_frame, text="Export to CSV", command=self.export_to_csv)
        export_button.pack(side=tk.LEFT, padx=5)

    def add_record(self):
        if not self.current_table:
            messagebox.showerror("Error", "No table selected")
            return

        # Окно для добавления записи
        fields = self.get_column_names()
        if not fields:
            return

        add_window = tk.Toplevel(self.root)
        add_window.title(f"Add Record to {self.current_table}")

        entries = {}
        for i, field in enumerate(fields):
            label = tk.Label(add_window, text=field)
            label.grid(row=i, column=0, padx=5, pady=5)
            entry = tk.Entry(add_window)
            entry.grid(row=i, column=1, padx=5, pady=5)
            entries[field] = entry

        def save_record():
            data = {field: entry.get() for field, entry in entries.items()}
            conn = connect_db()
            cur = conn.cursor()
            placeholders = ", ".join(["%s"] * len(data))
            query = f"INSERT INTO trade_organization.{self.current_table} ({', '.join(data.keys())}) VALUES ({placeholders})"
            try:
                cur.execute(query, list(data.values()))
                conn.commit()
                messagebox.showinfo("Success", "Record added successfully!")
                add_window.destroy()
                self.display_table(self.current_table)
            except Exception as e:
                messagebox.showerror("Error", f"Failed to add record: {e}")
            finally:
                conn.close()

        save_button = tk.Button(add_window, text="Save", command=save_record)
        save_button.grid(row=len(fields), column=0, columnspan=2, pady=10)

    def delete_record(self):
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showerror("Error", "No record selected")
            return

        record = self.tree.item(selected_item)["values"]
        if not record:
            messagebox.showerror("Error", "Invalid selection")
            return

        primary_key = record[0]
        conn = connect_db()
        cur = conn.cursor()
        try:
            cur.execute(f"DELETE FROM trade_organization.{self.current_table} WHERE id = %s", (primary_key,))
            conn.commit()
            messagebox.showinfo("Success", "Record deleted successfully!")
            self.display_table(self.current_table)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to delete record: {e}")
        finally:
            conn.close()

    def update_record(self):
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showerror("Error", "No record selected")
            return

        record = self.tree.item(selected_item)["values"]
        if not record:
            messagebox.showerror("Error", "Invalid selection")
            return

        fields = self.get_column_names()
        if not fields:
            return

        # Окно для обновления записи
        update_window = tk.Toplevel(self.root)
        update_window.title(f"Update Record in {self.current_table}")

        entries = {}
        for i, field in enumerate(fields):
            label = tk.Label(update_window, text=field)
            label.grid(row=i, column=0, padx=5, pady=5)
            entry = tk.Entry(update_window)
            entry.insert(0, str(record[i]))
            entry.grid(row=i, column=1, padx=5, pady=5)
            entries[field] = entry

        def save_update():
            updated_data = {field: entry.get() for field, entry in entries.items()}
            conn = connect_db()
            cur = conn.cursor()
            placeholders = ", ".join([f"{field} = %s" for field in fields])
            query = f"UPDATE trade_organization.{self.current_table} SET {placeholders} WHERE {fields[0]} = %s"
            try:
                cur.execute(query, list(updated_data.values()) + [record[0]])
                conn.commit()
                messagebox.showinfo("Success", "Record updated successfully!")
                update_window.destroy()
                self.display_table(self.current_table)
            except Exception as e:
                messagebox.showerror("Error", f"Failed to update record: {e}")
            finally:
                conn.close()

        save_button = tk.Button(update_window, text="Save", command=save_update)
        save_button.grid(row=len(fields), column=0, columnspan=2, pady=10)

    def search_record(self):
        if not self.current_table:
            messagebox.showerror("Error", "No table selected")
            return

        search_window = tk.Toplevel(self.root)
        search_window.title(f"Search in {self.current_table}")

        fields = self.get_column_names()
        if not fields:
            return

        entries = {}
        for i, field in enumerate(fields):
            label = tk.Label(search_window, text=f"Search by {field}:")
            label.grid(row=i, column=0, padx=5, pady=5)
            entry = tk.Entry(search_window)
            entry.grid(row=i, column=1, padx=5, pady=5)
            entries[field] = entry

        def execute_search():
            search_criteria = {field: entry.get() for field, entry in entries.items() if entry.get()}
            if not search_criteria:
                messagebox.showerror("Error", "No search criteria provided")
                return

            conditions = " AND ".join([f"{field}::text ILIKE %s" for field in search_criteria.keys()])
            values = [f"%{v}%" for v in search_criteria.values()]
            query = f"SELECT * FROM trade_organization.{self.current_table} WHERE {conditions}"

            conn = connect_db()
            cur = conn.cursor()
            try:
                cur.execute(query, values)
                rows = cur.fetchall()
                self.display_search_results(rows)
                search_window.destroy()
            except Exception as e:
                messagebox.showerror("Error", f"Failed to search: {e}")
            finally:
                conn.close()

        search_button = tk.Button(search_window, text="Search", command=execute_search)
        search_button.grid(row=len(fields), column=0, columnspan=2, pady=10)

    def display_search_results(self, rows):
        for widget in self.content_frame.winfo_children():
            widget.destroy()

        if not rows:
            messagebox.showinfo("Search Results", "No records found matching the criteria")
            return

        column_names = self.get_column_names()

        self.tree = ttk.Treeview(self.content_frame, columns=column_names, show="headings")
        for col in column_names:
            self.tree.heading(col, text=col)
            self.tree.column(col, width=100)
        self.tree.pack(fill=tk.BOTH, expand=True)

        for row in rows:
            self.tree.insert("", tk.END, values=row)

    def export_to_csv(self):
        if not self.current_table:
            messagebox.showerror("Error", "No table selected")
            return

        file_path = filedialog.asksaveasfilename(defaultextension=".csv",
                                                 filetypes=[("CSV files", "*.csv")])
        if not file_path:
            return

        conn = connect_db()
        cur = conn.cursor()
        cur.execute(f"SELECT * FROM trade_organization.{self.current_table}")
        rows = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]

        try:
            with open(file_path, "w", newline="") as file:
                writer = csv.writer(file)
                writer.writerow(column_names)
                writer.writerows(rows)
            messagebox.showinfo("Success", f"Data exported to {file_path}")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to export data: {e}")
        finally:
            conn.close()

    def get_column_names(self):
        # Получить названия столбцов текущей таблицы
        conn = connect_db()
        cur = conn.cursor()
        try:
            cur.execute(f"SELECT * FROM trade_organization.{self.current_table} LIMIT 1")
            return [desc[0] for desc in cur.description]
        except Exception as e:
            messagebox.showerror("Error", f"Failed to fetch columns: {e}")
            return []
        finally:
            conn.close()


if __name__ == "__main__":
    root = tk.Tk()
    app = DatabaseInterface(root)
    root.mainloop()
