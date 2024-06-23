//
//  MemoView.swift
//  voiceMemo
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @StateObject var memoViewModel: MemoViewModel
    @State var isCreateMode: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(
                leftBtnAction: {
                    pathModel.paths.removeLast()
                },
                rightBtnAction: {
                    if isCreateMode {
                        memoListViewModel.addMemo(memoViewModel.memo)
                    } else {
                        memoListViewModel.updateMemo(memoViewModel.memo)
                    }
                    pathModel.paths.removeLast()
                },
                rightBtnType: isCreateMode ? .create : .complete  
                )
                
                // 메모 타이틀 인풋 뷰
                MemoTitleInputView(
                    memoViewModel: memoViewModel,
                    isCreatedMode: $isCreateMode
                )
                .padding(.top, 20)
                
                // 메모 컨텐츠 인풋 뷰
                MemoContentInputView(memoViewModel: memoViewModel)
                    .padding(.top, 10)
        
                // 삭제 플로팅 버튼 뷰
                if !isCreateMode {
                    RemoveMemoBtnView(memoViewModel: memoViewModel)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

//MARK: - 메모 제목 입력 뷰
private struct MemoTitleInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    @FocusState private var isTitleFieldFoucsd: Bool
    @Binding private var isCreatedMode: Bool
    
    fileprivate init(
        memoViewModel: MemoViewModel,
        isCreatedMode: Binding<Bool>
    ) {
        self.memoViewModel = memoViewModel 
        self._isCreatedMode = isCreatedMode
    }
    
    fileprivate var body: some View {
        TextField(
            "제목을 입력하세요.",
            text: $memoViewModel.memo.title
        )
        .font(.system(size: 30))
        .padding(.horizontal, 20)
        .focused($isTitleFieldFoucsd)
        .onAppear {
            if isCreatedMode {
                isTitleFieldFoucsd = true
            }
        }
    }
}

//MARK: - 메모 본문 입력 뷰
private struct MemoContentInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        // textEditor에는 플레이스 홀더를 올리기 어려워, ZStack을 이용함.(여기서는)
        ZStack(alignment: .topLeading) {
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size: 20))
            
            if memoViewModel.memo.content.isEmpty {
                Text("메모를 입력하세요.")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.customGray1)
                    .allowsHitTesting(false) // textEditor 위에 Text를 올려서 플레이스를 홀더를 만든거라 text가 터치가 되면 안됨!!( text를 터치하더라도 text Editor 가 인식이 되도록 하기 위해서
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
        }
        .padding(.horizontal, 20)
    }
}

//MARK: - 메모 삭제 버튼 뷰
private struct RemoveMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    memoListViewModel.removeMemo(memoViewModel.memo)
                    pathModel.paths.removeLast()
                } label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
        }
    }
}



struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(
            memoViewModel: .init(
                memo: .init(
                    title: "",
                    content: "",
                    date: Date()
                )
            )
        )
    }
}

