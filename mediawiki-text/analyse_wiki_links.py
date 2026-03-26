"""
Analyse internal wiki page links in a MediaWiki XML export.

Parses all [[...]] constructs and categorises them into:
  - Page links (links to other pages in the same wiki)
  - Anchor links ([[#...]]) — same-page section references
  - File embeds ([[File:...]] / [[Image:...]])
  - Category links ([[Category:...]])
  - Media links ([[Media:...]])

Usage:
    python analyse_wiki_links.py <path-to-xml>
"""

import re
import sys
from collections import Counter


def analyse(filepath: str) -> dict:
    """Return a dict with categorised link counts and page-link details."""
    with open(filepath, "r", encoding="utf-8") as fh:
        content = fh.read()

    raw_links = re.findall(r"\[\[([^\]]+?)\]\]", content)

    anchors = 0
    files = 0
    categories = 0
    media = 0
    page_targets: list[str] = []

    for link in raw_links:
        target = link.split("|")[0].strip()
        if target.startswith("#"):
            anchors += 1
        elif target.startswith("File:") or target.startswith("Image:"):
            files += 1
        elif target.startswith("Category:"):
            categories += 1
        elif target.startswith("Media:"):
            media += 1
        else:
            page_targets.append(target)

    # Namespace breakdown for page links
    ns_counter: Counter[str] = Counter()
    for t in page_targets:
        if ":" in t:
            ns = t.split(":")[0]
            ns_counter[ns] += 1
        else:
            ns_counter["(main namespace)"] += 1

    unique_targets = sorted(set(page_targets))

    return {
        "total_constructs": len(raw_links),
        "page_links": len(page_targets),
        "anchor_links": anchors,
        "file_embeds": files,
        "category_links": categories,
        "media_links": media,
        "namespace_breakdown": ns_counter.most_common(),
        "unique_page_targets": unique_targets,
        "unique_count": len(unique_targets),
        "sample_page_links": page_targets[:20],
    }


def main() -> None:
    if len(sys.argv) < 2:
        print(f"Usage: python {sys.argv[0]} <mediawiki-xml-file>")
        sys.exit(1)

    filepath = sys.argv[1]
    results = analyse(filepath)

    print(f"Total [[...]] constructs found: {results['total_constructs']:,}")
    print()
    print("Breakdown:")
    print(f"  Page links (internal wiki pages): {results['page_links']:,}")
    print(f"  Anchor links (#...):              {results['anchor_links']:,}")
    print(f"  File embeds (File:/Image:):        {results['file_embeds']:,}")
    print(f"  Category links:                    {results['category_links']:,}")
    print(f"  Media links:                       {results['media_links']:,}")
    print()
    print(f"Unique page-link targets: {results['unique_count']:,}")
    print()
    print("Page links by namespace:")
    for ns, count in results["namespace_breakdown"]:
        print(f"  {ns}: {count:,}")
    print()
    print("Sample page links (first 20):")
    for t in results["sample_page_links"]:
        print(f"  [[{t}]]")


if __name__ == "__main__":
    main()
