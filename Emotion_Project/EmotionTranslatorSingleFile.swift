import SwiftUI

// Everything-in-one-file version of the Emotion Translator screen.
// Compare with the Domain / Data / Presentation layered version
// to see the same feature expressed two ways.

struct EmotionTranslatorSingleFileView: View {
    @State private var selectedID: UUID?

    private let shapes: [ShapeItem] = [
        ShapeItem(kind: .circle,   color: Color(red: 0.47, green: 0.80, blue: 0.26), size: 150, offset: CGSize(width: -110, height: -140)),
        ShapeItem(kind: .diamond,  color: Color(red: 0.78, green: 0.23, blue: 0.20), size: 150, offset: CGSize(width:   40, height: -110)),
        ShapeItem(kind: .star,     color: Color(red: 0.45, green: 0.93, blue: 0.78), size: 170, offset: CGSize(width:  -80, height:   30)),
        ShapeItem(kind: .pentagon, color: Color(red: 0.98, green: 0.86, blue: 0.20), size: 160, offset: CGSize(width:   80, height:   70)),
        ShapeItem(kind: .circle,   color: Color(red: 0.11, green: 0.26, blue: 0.86), size: 140, offset: CGSize(width: -120, height:  200)),
        ShapeItem(kind: .triangle, color: Color(red: 0.92, green: 0.15, blue: 0.70), size: 190, offset: CGSize(width:   40, height:  220)),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("EMOTIONAL\nTRANSLATOR")
                .font(.system(size: 44, weight: .heavy, design: .rounded))
                .lineSpacing(2)
                .padding(.horizontal, 24)
                .padding(.top, 32)

            Spacer(minLength: 0)

            ZStack {
                ForEach(shapes) { item in
                    shapeView(for: item)
                        .frame(width: item.size, height: item.size)
                        .foregroundStyle(item.color)
                        .overlay {
                            if selectedID == item.id {
                                outline(for: item)
                                    .stroke(Color.black, lineWidth: 4)
                                    .frame(width: item.size, height: item.size)
                            }
                        }
                        .scaleEffect(selectedID == item.id ? 1.08 : 1.0)
                        .shadow(color: selectedID == item.id ? item.color.opacity(0.5) : .clear, radius: 12)
                        .offset(item.offset)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedID = (selectedID == item.id) ? nil : item.id
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 480)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white.ignoresSafeArea())
    }

    @ViewBuilder
    private func shapeView(for item: ShapeItem) -> some View {
        switch item.kind {
        case .circle:   Circle()
        case .diamond:  Rectangle().rotation(.degrees(45))
        case .star:     SingleFileStar(points: 5)
        case .pentagon: SingleFilePentagon()
        case .triangle: SingleFileTriangle()
        }
    }

    private func outline(for item: ShapeItem) -> AnyShape {
        switch item.kind {
        case .circle:   AnyShape(Circle())
        case .diamond:  AnyShape(Rectangle().rotation(.degrees(45)))
        case .star:     AnyShape(SingleFileStar(points: 5))
        case .pentagon: AnyShape(SingleFilePentagon())
        case .triangle: AnyShape(SingleFileTriangle())
        }
    }
}

private struct ShapeItem: Identifiable {
    let id = UUID()
    let kind: Kind
    let color: Color
    let size: CGFloat
    let offset: CGSize

    enum Kind { case circle, diamond, star, pentagon, triangle }
}

private struct SingleFileTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

private struct SingleFilePentagon: Shape {
    func path(in rect: CGRect) -> Path {
        regularPolygonPath(sides: 5, in: rect, rotation: -.pi / 2)
    }
}

private struct SingleFileStar: Shape {
    let points: Int

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.42
        let step = .pi / Double(points)
        var path = Path()

        for i in 0..<(points * 2) {
            let radius = i.isMultiple(of: 2) ? outerRadius : innerRadius
            let angle = -.pi / 2 + Double(i) * step
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * radius,
                y: center.y + CGFloat(sin(angle)) * radius
            )
            if i == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        path.closeSubpath()
        return path
    }
}

private func regularPolygonPath(sides: Int, in rect: CGRect, rotation: Double) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    var path = Path()
    for i in 0..<sides {
        let angle = rotation + Double(i) * (2 * .pi / Double(sides))
        let point = CGPoint(
            x: center.x + CGFloat(cos(angle)) * radius,
            y: center.y + CGFloat(sin(angle)) * radius
        )
        if i == 0 { path.move(to: point) } else { path.addLine(to: point) }
    }
    path.closeSubpath()
    return path
}

#Preview {
    EmotionTranslatorSingleFileView()
}
