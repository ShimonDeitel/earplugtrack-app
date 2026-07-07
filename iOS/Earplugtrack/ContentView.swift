import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var purchases: PurchaseManager
    @State private var showAddSheet = false
    @State private var showSettings = false
    @State private var showPaywall = false

    @State private var newFlag = true
    @State private var newRating = 3
    @State private var newNote = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.entries) { entry in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(entry.date, style: .date).font(Theme.headlineFont).foregroundStyle(Theme.primary)
                            Spacer()
                            Image(systemName: entry.flag ? "checkmark.circle.fill" : "xmark.circle")
                                .foregroundStyle(entry.flag ? Theme.accent : Theme.secondary)
                        }
                        Text("Sleep Quality: \(entry.rating)/5").font(Theme.bodyFont).foregroundStyle(Theme.secondary)
                        if !entry.note.isEmpty {
                            Text(entry.note).font(Theme.captionFont).foregroundStyle(Theme.secondary)
                        }
                    }
                    .listRowBackground(Theme.cardBackground)
                }
                .onDelete(perform: store.delete)
            }
            .scrollContentBackground(.hidden)
            .background(Theme.background.ignoresSafeArea())
            .navigationTitle("Earplugtrack")

            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .accessibilityIdentifier("settingsButton")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if store.isAtLimit && !purchases.isPro {
                            showPaywall = true
                        } else {
                            showAddSheet = true
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addEntryButton")
                }
            }
            .sheet(isPresented: $showSettings) { SettingsView() }
            .sheet(isPresented: $showPaywall) { PaywallView() }

            .sheet(isPresented: $showAddSheet) {
                NavigationStack {
                    Form {
                        Toggle("Wore Earplugs", isOn: $newFlag)
                            .accessibilityIdentifier("flagToggle")
                        Stepper("Sleep Quality: \(newRating)", value: $newRating, in: 1...5)
                            .accessibilityIdentifier("ratingStepper")
                        TextField("Note", text: $newNote)
                            .accessibilityIdentifier("noteField")
                    }
                    .navigationTitle("New Entry")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { showAddSheet = false }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                store.add(Entry(date: Date(), flag: newFlag, rating: newRating, note: newNote))
                                newFlag = true; newRating = 3; newNote = ""
                                showAddSheet = false
                            }
                            .accessibilityIdentifier("saveEntryButton")
                        }
                    }
                    .background(
                        Color.clear.contentShape(Rectangle())
                            .onTapGesture { hideKeyboard() }
                    )
                }
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
