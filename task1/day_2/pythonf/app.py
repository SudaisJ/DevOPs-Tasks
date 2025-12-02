from pathlib import Path
import json

def main():
    user = "Sudais"
    data = {
        "message": f"hey {user}! Your app is running inside the docker ",
        "status": "success"
    }

    Path("output.json").write_text(json.dumps(data, indent=2))
    print("Output written to output.json ✔")

if __name__ == "__main__":
    main()
