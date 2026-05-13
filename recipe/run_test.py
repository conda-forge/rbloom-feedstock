from rbloom import Bloom


def main():
    bloom = Bloom(100, 0.01)
    bloom.add("robot")

    assert "robot" in bloom
    assert "simulation" not in bloom
    assert bloom.approx_items >= 1

    copied = bloom.copy()
    assert "robot" in copied

    other = Bloom(100, 0.01)
    other.add("simulation")
    union = bloom.union(other)
    assert "robot" in union
    assert "simulation" in union


if __name__ == "__main__":
    main()
