from rbloom import Bloom


def main():
    bloom = Bloom(1000, 0.0001)
    bloom.update(["robot", "simulation"])

    assert "robot" in bloom
    assert "simulation" in bloom

    copied = bloom.copy()
    assert "robot" in copied
    assert copied.issubset(bloom)

    bloom.clear()
    assert "robot" not in bloom

    other = Bloom(1000, 0.0001)
    other.add("planning")
    union = copied.union(other)
    assert "robot" in union
    assert "simulation" in union
    assert "planning" in union
    assert union.issuperset(copied)

    intersection = union.intersection(copied)
    assert "robot" in intersection
    assert "simulation" in intersection


if __name__ == "__main__":
    main()
