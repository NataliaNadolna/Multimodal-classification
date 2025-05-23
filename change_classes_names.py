

negative = [
    "boisterous", "rowdy", "agressive", "tense - anxious",
    "volatile", "visceral", "fiery", "intense"
]

positive = [
    "amiable-good natured", "cheerful", "rousing", "rollicking",
    "confident", "passionate", "campy", "humorous", "silly",
    "whimsical", "witty", "wry", "fun"
]

nostalgic = [
    "autumnal", "bittersweet", "brooding", "poignant", "wistful",
    "sweet", "literate"
] 

# Mapowanie
def map_class(label):
    label = label.strip().lower()
    if label in negative:
        return "negative"
    elif label in positive:
        return "positive"
    elif label in nostalgic:
        return "nostalgic"
    else:
        return "unknown"

# Wczytaj dane z pliku i zapisz zmapowane etykiety do nowego pliku
input_file = "dataset - original/categories.txt"          # ← tu wpisz swoją ścieżkę do pliku
output_file = "klasy_mapped.txt"  # ← tu plik wynikowy

with open(input_file, "r", encoding="utf-8") as f:
    lines = f.readlines()

mapped = [map_class(line) + "\n" for line in lines]

with open(output_file, "w", encoding="utf-8") as f:
    f.writelines(mapped)

print("Gotowe. Zapisano do", output_file)
